class AddQuestionCategoryToLinks < ActiveRecord::Migration
  def change
    add_column :links, :question_category, :string
  end
end
