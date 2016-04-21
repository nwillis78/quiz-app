class AddGroupIdToUserQuizzes < ActiveRecord::Migration
  def change
    add_column :user_quizzes, :group_id, :integer
  end
end
