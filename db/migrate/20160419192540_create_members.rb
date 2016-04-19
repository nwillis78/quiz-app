class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :student_id
      t.references :group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
