class CreateApiV1Canvases < ActiveRecord::Migration[5.0]
  def change
    create_table :api_v1_canvases do |t|
      t.string     :name,    null: false
      t.integer :diagram_id, index: true

      t.timestamps
    end
  end
end
