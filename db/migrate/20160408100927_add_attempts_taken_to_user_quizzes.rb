class AddAttemptsTakenToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :attemptsTaken, :string
  end
end
