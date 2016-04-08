class AddResultToUserQuiz < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :result, :integer
  end
end
