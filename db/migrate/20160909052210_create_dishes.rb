class CreateDishes < ActiveRecord::Migration[5.0]
  def change
    create_table :dishes do |t|
      t.string  :description
      t.integer :first_appeared
      t.decimal :highest_price, precision: 6, scale: 2
      t.integer :last_appeared
      t.decimal :lowest_price, precision: 6, scale: 2
      t.integer :menus_appeared
      t.string  :name
      t.integer :times_appeared

      t.timestamps
    end
  end
end
