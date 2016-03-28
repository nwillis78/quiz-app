class AddUserToQuizzes < ActiveRecord::Migration
  def change
    add_reference :quizzes, :user, index: true, foreign_key: true
  end
end
