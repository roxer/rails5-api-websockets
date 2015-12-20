class CreateApiV1Shapes < ActiveRecord::Migration[5.0]
  def change
    create_table :api_v1_shapes do |t|
      t.string :label
      t.string :shape_type
      t.text   :descriptors
      t.integer :pos_x
      t.integer :pos_y
      t.references :canvas, index: true, foreign_key: true

      t.timestamps
    end
  end
end
