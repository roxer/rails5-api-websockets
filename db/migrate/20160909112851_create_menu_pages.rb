class CreateMenuPages < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_pages do |t|
      t.references :menu, foreign_key: true
      t.integer    :page_number
      t.string     :image_id
      t.integer    :full_height
      t.integer    :full_width
      t.uuid       :uuid

      t.timestamp  :created_at , null: true
      t.timestamp  :updated_at , null: true
    end
  end
end
