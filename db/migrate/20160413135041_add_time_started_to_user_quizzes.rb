class AddTimeStartedToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :time_started, :timestamp
  end
end
