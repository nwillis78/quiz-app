class Answer < ActiveRecord::Base
  belongs_to :question

  validates :answerString, presence: true, length: { minimum: 3}
end
