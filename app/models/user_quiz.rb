class UserQuiz < ActiveRecord::Base
    belongs_to :quiz
    has_many :results, dependent: :destroy

    validates :quiz_id, presence: true
    validates :group_id, presence: true
    validates :staff_id, presence: true
    validates :student_id, presence: true
    validate :start_not_in_past
	validate :end_not_in_past_after_start

  	def start_not_in_past
	    if start_date.present? && start_date < Date.today
	    	errors.add(:start_date, "can't be in the past")
	  	else
	  		true
	    end
  	end   

  	def end_not_in_past_after_start
  		#check end date isn't in the past
  		if end_date.present? && end_date < Date.today
	    	errors.add(:end_date, "can't be in the past")
	  	else
	  		#end date not in past so check it is after start
	  		if end_date < start_date
	  			errors.add(:end_date, "can't be before the Start date")
	  		else
	  			true
	  		end
	    end
  	end
end
