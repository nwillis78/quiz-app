class RemoveQuizIdFromResults < ActiveRecord::Migration
  def change
    remove_column :results, :quiz_id, :integer
  end
end
