class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string  :call_number
      t.string  :currency
      t.string  :currency_symbol
      t.date    :sheduled_on
      t.integer :dishes_count
      t.string  :event_orig
      t.string  :keywords
      t.string  :language
      t.string  :location
      t.string  :location_type
      t.string  :name
      t.text    :notes
      t.string  :occasion
      t.integer :menu_pages_count
      t.string  :physical_description
      t.string  :place_orig
      t.string  :sponsor
      t.string  :status
      t.integer :status_id
      t.string  :venue_orig

      t.references :event, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamp  :created_at , null: true
      t.timestamp  :updated_at , null: true
    end
  end
end
