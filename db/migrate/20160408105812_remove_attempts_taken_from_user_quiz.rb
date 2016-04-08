class RemoveAttemptsTakenFromUserQuiz < ActiveRecord::Migration
  def change
    remove_column :user_quizzes, :attemptsTaken, :string
  end
end
