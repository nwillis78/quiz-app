class QuizPagesController < ApplicationController
	def index
		@quiz = Quiz.find(UserQuiz.find(params[:userQuiz]).quiz_id)
		@userQuiz = UserQuiz.find(params[:userQuiz])
		@attemptRemaining = @quiz.attemptsAllowed - @userQuiz.attemptsTaken
	end

	def new
		@quiz = Quiz.find(UserQuiz.find(params[:userQuiz]).quiz_id)
		@userQuiz = UserQuiz.find(params[:userQuiz])
	end

	def grading
		 @userQuiz = UserQuiz.find(params[:userQuiz])
		 total = Quiz.find(@userQuiz.quiz_id).questions.count.to_i

		 session[:total]   = total
		 session[:correct] = 0
		 @total   = session[:total]

		 h = params[:answer]

		h.values.each do |answer|
  			@answer = answer ? Answer.find(answer) : nil

			  if @answer and @answer.isCorrect
			    @correct = true
			    session[:correct] += 1
			  else
			    @correct = false
			  end
	    end

		 @correct = session[:correct]

  		 @score = @correct * 100 / @total

  		 @userQuiz.result = @score
		 @userQuiz.attemptsTaken += 1
  		 @userQuiz.save

		redirect_to root_path
	end
end
