class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  helper_method :calculate_status
  
  def index
  	#for the staff index display need to only return one item per group
  	 @allUserQuizzes = UserQuiz.where("staff_id = ?", current_user.id)
  	 @userQuizzes = UserQuiz.none
  	 @allUserQuizzes.each do |userQuiz|
  	 	@matches = @userQuizzes.where("group_id = ?", userQuiz.group_id).where("quiz_id = ?", userQuiz.quiz_id)
  	
  	 	if @matches.count == 0
  	 		@new = @allUserQuizzes.where("group_id = ?", userQuiz.group_id).where("quiz_id = ?", userQuiz.quiz_id).first

  	 		@array = @userQuizzes + Array(@new)
			@userQuizzes = UserQuiz.where(:id => @array)
  	 	end
  	 end

  	@studentQuizzes = UserQuiz.where("student_id = ?", current_user.id)
  end

  	def calculate_status(start_date, end_date) #this method is also in the user quizzes controller
		if Date.today.between?(start_date, end_date)
		  return "Live"
		else
		  if Date.today < start_date
		  	return "Scheduled for Release"
		  elsif end_date < Date.today
		  	return "Closed"
		  end
		end
	end

 
end
