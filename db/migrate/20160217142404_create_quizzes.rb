class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :title
      t.text :description
      t.text :instructions

      t.timestamps null: false
    end
  end
end
