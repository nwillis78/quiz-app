class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  helper_method :calculate_status
  
  def index
  	@userQuizzes = UserQuiz.where("staff_id = ?", current_user.id)
  	@studentQuizzes = UserQuiz.where("student_id = ?", current_user.id)
  end

  	def calculate_status(start_date, end_date)
		if Date.today.between?(start_date, end_date)
		  return "Live"
		else
		  if Date.today < start_date
		  	return "Scheduled for Release"
		  elsif end_date > Date.today
		  	return "Closed"
		  end
		end
	end

 
end
