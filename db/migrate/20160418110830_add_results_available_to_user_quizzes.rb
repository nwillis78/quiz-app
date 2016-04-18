class AddResultsAvailableToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :results_available, :boolean
  end
end
