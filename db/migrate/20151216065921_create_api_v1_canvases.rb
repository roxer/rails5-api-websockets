class CreateApiV1Canvases < ActiveRecord::Migration[5.0]
  def change
    create_table :api_v1_canvases do |t|
      t.string :name
      t.references :api_v1_diagram, index: true, foreign_key: true

      t.timestamps
    end
  end
end
