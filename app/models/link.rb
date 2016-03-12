class Link < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :question


  accepts_nested_attributes_for :question
end
