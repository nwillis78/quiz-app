class AddAttemptsTakenToUserQuiz < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :attemptsTaken, :integer
  end
end
