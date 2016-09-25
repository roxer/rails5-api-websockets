class CreateApiV1Shapes < ActiveRecord::Migration[5.0]
  def change
    create_table :api_v1_shapes do |t|
      t.string :label, null: false
      t.string :shape_type, null: false
      t.text   :descriptors, null: false
      t.integer :pos_x, null: false
      t.integer :pos_y, null: false
      t.references :api_v1_canvas, index: true, foreign_key: true

      t.timestamps
    end
  end
end
