class CreateMenusVenuesJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :menus, :venues do |t|
      t.references :menu, foreign_key: true
      t.references :venue, foreign_key: true
    end

    add_index :menus_venues, [:menu_id, :venue_id], unique: true
  end

end
