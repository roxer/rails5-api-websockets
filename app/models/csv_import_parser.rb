# encoding: utf-8
# frozen_string_literal: true
require 'csv'
require 'parallel'
require 'set'

class CSVImportParser
  attr_reader   :data_file
  attr_accessor :fields

  PROCESSES = 4

  def initialize(id)
    @data_file = DataFile.find(id)
    @fields = {event_orig: Set.new, place_orig: Set.new, venue_orig: Set.new}
  end

  def process
    mi_path = data_file.menu_item.current_path
    di_path = data_file.dish.current_path
    system("split -l 50000 #{mi_path} ./tmp/mi_") # REVIEW: split big files
    system("split -l 40000 #{di_path} ./tmp/di_")
    clear_db

    # REVIEW: order is important to have foreign keys validation
    dependency_hash = TsortableHash[
                        dish:      [],
                        menu:      [],
                        menu_item: [:dish, :menu_page],
                        menu_page: [:menu], # REVIEW: prefere comma to keep keys sorted
                      ]

    dependency_hash.tsort.each do |table|
      broadcast("started", "processing table #{table} ...")
      self.send("import_#{table}") # REVIEW: easy to maintain dependencies
      broadcast("finished", "processing table #{table} ...")
    end

  ensure
    system("rm ./tmp/{mi,di}_*") # REVIEW: ensure you have cleaned up
  end

  private

  def broadcast(action, text)
    t   = Time.now.strftime("%H-%M-%S")
    msg = {action: {event: action, type: 'import'}, body: "#{t} #{text}"}.to_json
    ActionCable.server.broadcast("data_file_#{data_file.id}", msg)
  end

  def import_dish
    # REVIEW: Dir.glob isn't thread safe so it is useless
    # chunks = Dir.glob(File.join(Rails.root, 'tmp','di_*'))

    path   = File.join(Rails.root, 'tmp')
    chunks = Dir.entries(path).select { |i| i =~ /^di_/ }

    # REVIEW: parallel procesing
    Parallel.each(chunks, in_processes: PROCESSES) do |chunk|
      dish_worker(chunk: chunk)
    end

    ActiveRecord::Base.connection.reconnect! # HACK: Paraller issue workaround
  rescue
    ActiveRecord::Base.connection.reconnect! # HACK: Paraller issue workaround
  end

  def import_menu
    rows = []
    menu_venues = Set.new

    file = data_file.menu.current_path

    CSV.foreach(file, headers: false) do |row|
      next unless row_valid?(row: row, cols: Menu::COLS[0...-2])

      # REVIEW: extract fiels for relations
      %i(event_orig venue_orig place_orig).each do |p|
        p_id = \
          extract_field(
            row:   row[Menu::COLS.index(p)],
            field: p
          )

        case p
        when :place_orig
          row[Menu::COLS.index(:place_id)] = p_id
        when :event_orig
          row[Menu::COLS.index(:event_id)] = p_id
        when :venue_orig
          p_id.each do |i|
            menu_venues << [row[Menu::COLS.index(:id)], i]
          end rescue nil
        end
      end

      rows << row
    end

    Menu.transaction do
      Venue.import!(
        [:id, :name],
        fields[:venue_orig].map! { |v| [fields[:venue_orig].find_index(v) + 1, v] }.to_a,
        validate:   false,
        timestamps: true
      )
    end
    broadcast("finished", "imported Venue - #{fields[:venue_orig].size}")

    Menu.transaction do
      Place.import!(
        [:id, :name],
        fields[:place_orig].map! { |v| [fields[:place_orig].find_index(v) + 1, v] }.to_a,
        validate:   false,
        timestamps: true
      )
    end
    broadcast("finished", "imported Place - #{fields[:place_orig].size}")

    Menu.transaction do
      Event.import!(
        [:id, :name],
        fields[:event_orig].map! { |v| [fields[:event_orig].find_index(v) + 1, v] }.to_a,
        validate:   false,
        timestamps: true
      )
    end
    broadcast("finished", "imported Event - #{fields[:event_orig].size}")

    Menu.transaction do
      Menu.import(
        Menu::COLS,
        rows,
        on_duplicate_key_update: Menu::COLS.drop(1), # REVIEW: overwrite duplicate keys
        batch_size:              10_000,
        validate:                false,
        timestamps:              true
      )
    end
    broadcast("finished", "imported Menu - #{rows.size}")

    Menu.transaction do
      MenusVenue.import(
        [:menu_id, :venue_id],
        menu_venues.to_a,
        validate:   false,
        timestamps: false
      )
    end
    broadcast("finished", "imported MenusVenue - #{menu_venues.size}")
  end

  def import_menu_page
    file = data_file.menu_page.current_path
    rows = []
    menu_ids = Menu.order(:id).ids # REVIEW: for binary search

    CSV.foreach(file, headers: false) do |row|
      rows << row if row_valid?(row: row, cols: MenuPage::COLS, menu_id: menu_ids)
    end

    MenuPage.transaction do
      MenuPage.import(
        MenuPage::COLS, rows,
        on_duplicate_key_update: MenuPage::COLS.drop(1),
        batch_size:              10_000,
        validate:                false
      )
    end
    broadcast("finished", "imported MenuPage - #{rows.size}")
  end

  def import_menu_item
    menu_page_ids = MenuPage.order(:id).ids
    dish_ids      = Dish.order(:id).pluck(:id) # REVIEW: the same as above (.ids)
    path          = File.join(Rails.root, 'tmp')
    chunks        = Dir.entries(path).select { |i| i =~ /^mi_/ }

    Parallel.each(chunks, in_processes: PROCESSES) do |chunk|
      menu_item_worker(
        chunk:         chunk,
        menu_page_ids: menu_page_ids,
        dish_ids:      dish_ids
      )
    end

    ActiveRecord::Base.connection.reconnect! # HACK: Paraller issue workaround
  rescue
    ActiveRecord::Base.connection.reconnect! # HACK: Paraller issue workaround
  end

  def menu_item_worker(chunk:, menu_page_ids:, dish_ids:)
    # Rails.logger.debug "starting menu item worker ..."

    rows = []
    file = File.join(Rails.root, 'tmp', chunk)
    data = CSV.read(file, row_sep: "\n",
                          col_sep: ",",
                          headers: false)

    data.each do |row|
      rows << row if row_valid?(row:           row,
                                cols:         MenuItem::COLS,
                                menu_page_id: menu_page_ids,
                                dish_id:      dish_ids)
    end

    MenuItem.transaction do
      MenuItem.import(
        MenuItem::COLS, rows,
        on_duplicate_key_update: MenuItem::COLS.drop(1),
        batch_size:              10_000,
        validate:                false
      )
    end
    broadcast("updated", "imported part of MenuItem - #{rows.size} rows")

    Parallel::Stop
  end

  def dish_worker(chunk:)
    broadcast("started", "dish worker #{chunk} ...")

    rows = []
    file = File.join(Rails.root, 'tmp', chunk)
    data = CSV.read(file, row_sep: "\n",
                          col_sep: ",",
                          headers: false)

    data.each do |row|
      rows << row if row_valid?(row:  row,
                                cols: Dish::COLS)
    end

    Dish.transaction do
      Dish.import(
        Dish::COLS, rows,
        on_duplicate_key_update: Dish::COLS.drop(1),
        batch_size:              10_000,
        validate:                false
      )
      # Rails.logger.debug "dishes imported #{rows.size}"
    end
    broadcast("updated", "table Dish - imported #{rows.size} rows")

    Parallel::Stop
  end

  def row_valid?(row:, cols:, **options)
    return false if row.size != cols.size || row.first.to_i <= 0

    # REVIEW: use binary search to discard bad rows
    options.each do |key, val|
      idx = cols.index(key)
      return false unless val.bsearch { |x| row[idx].to_i - x }
    end

    true
  rescue
    false
  end

  def extract_field(row:, field:)
    return nil unless row
    row.upcase!
    row.tr!('()[]{}?.', '') # REVIEW: faster than gsub
    row.strip!
    return nil if row.blank?

    if field == :venue_orig
      res = row.split(/[,;:]\s*/)
               .map(&:strip)
               .reject { |r| r == 'NULL' } # REVIEW: ignore NULL values

      ids = []
      res.each do |v|
        fields[:venue_orig] << v
        ids << fields[:venue_orig].find_index(v) + 1
      end

      return ids
    else
      fields[field] << row
      return fields[field].find_index(row) + 1
    end
  end

  def clear_db
    broadcast("started", "deleting data from tables")
    MenusVenue.delete_all
    Place     .delete_all
    Venue     .delete_all
    MenuItem  .delete_all
    MenuPage  .delete_all
    Menu      .delete_all
    Event     .delete_all
    Dish      .delete_all
  end
end

class TsortableHash < Hash
  include TSort
  alias tsort_each_node each_key

  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end
