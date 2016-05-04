class Answer < ActiveRecord::Base
  belongs_to :question

  validates :answerString, presence: true
end
