class AddShuffleQuestionsToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :shuffleQuestions, :bit
  end
end
