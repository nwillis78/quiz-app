class AddDirectionRefToLanguage < ActiveRecord::Migration
  def change
    add_reference :languages, :direction, index: true, foreign_key: true
  end
end
