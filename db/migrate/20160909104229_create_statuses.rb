class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.string :name

      t.timestamps
    end

    add_index(:statuses, :name, unique: true)
  end

end
