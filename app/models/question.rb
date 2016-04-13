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
    
    validates :answers, association_count: {minimum: 1}
    validates_associated :answers

    def check_has_answer
	    if ((answers.length == 0) || (answers.reject(&:marked_for_destruction?).count == 0))
	        self.errors.add :base, "Question must have at least one answer"
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

end
