class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.string :directionName
      t.string :directionCode

      t.timestamps null: false
    end
  end
end
