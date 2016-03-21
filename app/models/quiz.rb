class Quiz < ActiveRecord::Base
	has_many :links
	has_many :questions, through: :links

	accepts_nested_attributes_for :links, :allow_destroy => true
	accepts_nested_attributes_for :questions
    
    validates :title, presence: true,
    length: { minimum: 3 }


    def getNoQuestions
	    questions.length
	end

end