class Quiz < ActiveRecord::Base
	has_many :links
	has_many :questions, through: :links
	belongs_to :user
	belongs_to :language
	has_many :user_quizzes

	accepts_nested_attributes_for :links, :allow_destroy => true
	accepts_nested_attributes_for :questions
    
    validates :title, presence: true,
    length: { minimum: 3 }

	validates :attemptsAllowed, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10, :message => "the number of attempts allowed must be between 1 and 10" }


    def getNoQuestions
	    questions.length
	end

end