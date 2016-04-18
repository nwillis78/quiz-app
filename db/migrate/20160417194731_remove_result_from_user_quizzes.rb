class RemoveResultFromUserQuizzes < ActiveRecord::Migration
  def change
    remove_column :user_quizzes, :result, :integer
  end
end
