class Language < ActiveRecord::Base
    before_destroy -> { check_if_in_question_or_quiz('destroy') }
    before_update -> {check_if_in_question_or_quiz('update')}
	belongs_to :direction
	belongs_to :user
	has_many :question
	has_many :quiz

	validates :languageName, presence: true, uniqueness: true,
                    length: { minimum: 3 }
    validates :direction_id, presence: true

    def check_if_in_question_or_quiz(method)
    	inQuestion = false
    	inQuiz = false

    	#check if present in a question
        @questions = Question.all
        @questions.each do |question|
            if question.language_id == self.attributes['id']
                inQuestion = true
            end
        end

        #check if present in a quiz
        @quizzes = Quiz.all
        @quizzes.each do |quiz|
            if quiz.language_id == self.attributes['id']
                inQuiz = true
            end
        end

        if inQuiz && inQuestion
        	errors.add(:base, "Cannot "+method+" language while it is in use in a question and a quiz")
            return false
        elsif inQuiz
        	errors.add(:base, "Cannot "+method+" language while it is in use in a quiz")
            return false
        elsif inQuestion
        	errors.add(:base, "Cannot "+method+" language while it is in use in a question")
            return false
        end
    end
end
