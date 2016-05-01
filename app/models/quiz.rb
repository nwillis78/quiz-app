class Quiz < ActiveRecord::Base
	before_destroy -> { check_if_set('destroy') }
    before_update -> {check_if_set('update')}

	has_many :links
	has_many :questions, through: :links
	belongs_to :user
	belongs_to :language
	has_many :user_quizzes


	accepts_nested_attributes_for :links, :allow_destroy => true
	accepts_nested_attributes_for :questions
    
    validates :language_id, presence: true
    validates :title, presence: true, length: { minimum: 3 }
    validates :description, presence: true, length: {minimum: 3}
    validates :instructions, presence: true, length: {minimum: 3}
	validates :attemptsAllowed, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10, :message => "the number of attempts allowed must be between 1 and 10" }
	validates :time_allowed, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 120, :message => "the time allowed must be between 1 and 120 minutes" }

    def getNoQuestions
	    questions.length
	end

	def check_if_set(method)
		@userQuizzes = UserQuiz.all


		@userQuizzes.each do |userQuiz|
			if userQuiz.quiz_id == self.attributes['id']
				errors.add(:base, "Cannot "+method+" quiz while it has been set to students")
				return false
			end
		end
    end

end