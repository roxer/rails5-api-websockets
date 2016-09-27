class CreateDataFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :data_files do |t|
      t.json :sources
      t.string :menu
      t.string :dish
      t.string :menu_item
      t.string :menu_page

      t.timestamps
    end
  end
end
