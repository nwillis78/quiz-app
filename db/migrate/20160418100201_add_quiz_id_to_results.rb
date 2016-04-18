class AddQuizIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :quiz_id, :integer
  end
end
