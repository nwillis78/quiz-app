class AddQuestionIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :question_id, :integer
  end
end
