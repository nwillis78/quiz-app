class AddAttemptsAllowedToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :attemptsAllowed, :tinyint
  end
end
