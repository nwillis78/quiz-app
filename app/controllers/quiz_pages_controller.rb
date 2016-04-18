class QuizPagesController < ApplicationController
	

	def index
		@quiz = Quiz.find(UserQuiz.find(params[:userQuiz]).quiz_id)
		@userQuiz = UserQuiz.find(params[:userQuiz])
		@attemptRemaining = @quiz.attemptsAllowed - @userQuiz.attemptsTaken
		@time_allowed = @quiz.time_allowed

		@direction = Direction.find(Language.find(@quiz.language_id).direction_id).directionCode	
	end

	def new
		@quiz = Quiz.find(UserQuiz.find(params[:userQuiz]).quiz_id)
		@userQuiz = UserQuiz.find(params[:userQuiz])
		@direction = Direction.find(Language.find(@quiz.language_id).direction_id).directionCode


		@userQuiz.attemptsTaken += 1
		@userQuiz.time_started = DateTime.now
  		@userQuiz.save

  		@time_started = @userQuiz.time_started
  		@time_allowed = @quiz.time_allowed
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

	def save_results
		@userQuiz = UserQuiz.find(params[:userQuiz])
		answers = params[:answer]

		#an attempt is being saved, it is possible that data from previous attempts still exists
		#before saving anything new wipe existing results from the db
		@oldResults = Result.where("user_quiz_id = ?", @userQuiz.id)

		@oldResults.each do |oldResult|
			oldResult.destroy
		end

		answers.values.each do |answer|
			@answer = answer ? Answer.find(answer) : nil
			Result.create(
			    :user_quiz_id => @userQuiz.id, 
			    :chosen_answer => @answer.id,
			    :question_id => @answer.question_id)
		end

		redirect_to root_path
	end


end
