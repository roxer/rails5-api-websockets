class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.references :dish, foreign_key: true
      t.decimal    :high_price, precision: 10, scale: 2
      t.references :menu_page, foreign_key: true
      t.decimal    :price, precision: 10, scale: 2
      t.float      :xpos
      t.float      :ypos

      t.timestamps
    end
  end
end
