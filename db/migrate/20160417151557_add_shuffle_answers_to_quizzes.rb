class AddShuffleAnswersToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :shuffleAnswers, :boolean
  end
end
