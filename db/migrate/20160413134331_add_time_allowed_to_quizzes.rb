class AddTimeAllowedToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :time_allowed, :integer
  end
end
