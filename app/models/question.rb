class Question < ActiveRecord::Base
    require_dependency 'lib/association_count_validator.rb'
    before_destroy -> { check_if_in_quiz('destroy') }
    before_update -> {check_if_in_quiz('update')}

    belongs_to :category
    belongs_to :user
    belongs_to :language

    has_many :links
    has_many :quizzes, through: :links

    has_many :answers, dependent: :destroy, :autosave => true
    accepts_nested_attributes_for :answers, allow_destroy: true
    
    validates :category_id, presence: true
    validates :body, presence: true,
    length: { minimum: 3}
    
    
    validates_associated :answers
    validate :has_one_correct_answer
    validate :check_has_answer

    def check_has_answer
	    if ((answers.length == 0) || (answers.reject(&:marked_for_destruction?).count == 0))
	        errors.add(:base, "Question must have at least one answer")
	    end
	end

    def check_if_in_quiz(method)
        @quizzes = Quiz.all
        @quizzes.each do |quiz|
            quiz.questions.each do |question|
                if question.id == self.attributes['id']
                    errors.add(:base, "Cannot "+method+" question while it is in use in a quiz")
                    return false
                end
            end
        end
    end

    

    def has_one_correct_answer
        @i = 0;
        answers.each do |answer|
            if answer.isCorrect
                @i+=1
            end
        end
        if @i ==1
            return true
        else
            errors.add(:base, "Question must have exactly 1 correct answer")
            return false
        end
    end   

end
