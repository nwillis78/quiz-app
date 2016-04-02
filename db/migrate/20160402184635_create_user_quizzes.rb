class CreateUserQuizzes < ActiveRecord::Migration
  def change
    create_table :user_quizzes do |t|
      t.references :quiz, index: true, foreign_key: true
      t.integer :staff_id
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
