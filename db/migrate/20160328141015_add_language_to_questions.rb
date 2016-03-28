class AddLanguageToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :language, index: true, foreign_key: true
  end
end
