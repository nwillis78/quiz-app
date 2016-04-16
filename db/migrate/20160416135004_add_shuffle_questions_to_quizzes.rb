class AddShuffleQuestionsToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :shuffleQuestions, :boolean
  end
end
