class AddLanguageToQuizzes < ActiveRecord::Migration
  def change
    add_reference :quizzes, :language, index: true, foreign_key: true
  end
end
