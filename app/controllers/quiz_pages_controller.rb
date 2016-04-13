class QuizPagesController < ApplicationController
	def index
		@quiz = Quiz.find(UserQuiz.find(params[:userQuiz]).quiz_id)
		@userQuiz = UserQuiz.find(params[:userQuiz])
		@attemptRemaining = @quiz.attemptsAllowed - @userQuiz.attemptsTaken

		@direction = Direction.find(Language.find(@quiz.language_id).direction_id).directionCode	
	end

	def new
		@quiz = Quiz.find(UserQuiz.find(params[:userQuiz]).quiz_id)
		@userQuiz = UserQuiz.find(params[:userQuiz])
		@direction = Direction.find(Language.find(@quiz.language_id).direction_id).directionCode

		@userQuiz.attemptsTaken += 1
  		@userQuiz.save
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
  		 @userQuiz.save

		redirect_to root_path
	end
end
