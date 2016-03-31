class Category < ActiveRecord::Base
	before_destroy :check_if_in_question

	has_many :question
	belongs_to :user

	validates :categoryBody, presence: true, uniqueness: true,
                    length: { minimum: 3 }

    def check_if_in_question
        @questions = Question.all
        @questions.each do |question|
            if question.category_id == self.attributes['id']
                errors.add(:base, "Cannot delete category while it is in use in a question")
                return false
            end
        end
    end

end
