class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@userQuizzes = UserQuiz.where("staff_id = ?", current_user.id)
  	@studentQuizzes = UserQuiz.where("student_id = ?", current_user.id)
  end

 
end
