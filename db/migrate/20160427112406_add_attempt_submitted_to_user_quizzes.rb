class AddAttemptSubmittedToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :attempt_submitted, :boolean
  end
end
