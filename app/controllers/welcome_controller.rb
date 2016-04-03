class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  	@noQuizzes = Quiz.where("user_id = ?", current_user.id).count
  	@userQuizzes = UserQuiz.where("staff_id = ?", current_user.id)
  end

 
end
