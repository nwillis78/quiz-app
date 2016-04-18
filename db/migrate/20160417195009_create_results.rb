class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :chosen_answer
      t.references :user_quiz, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
