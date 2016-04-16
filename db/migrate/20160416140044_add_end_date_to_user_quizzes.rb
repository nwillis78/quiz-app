class AddEndDateToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :end_date, :date
  end
end
