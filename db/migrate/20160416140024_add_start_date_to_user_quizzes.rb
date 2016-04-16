class AddStartDateToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :start_date, :date
  end
end
