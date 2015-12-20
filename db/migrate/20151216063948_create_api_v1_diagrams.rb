class CreateApiV1Diagrams < ActiveRecord::Migration[5.0]
  def change
    create_table :api_v1_diagrams do |t|
      t.string :name

      t.timestamps
    end
  end
end
