class CreateVenues < ActiveRecord::Migration[5.0]
  def change
    create_table :venues do |t|
      t.string :name

      t.timestamps
    end
    add_index(:venues, :name, unique: true)

  end
end
