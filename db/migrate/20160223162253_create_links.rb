class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :quiz, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
