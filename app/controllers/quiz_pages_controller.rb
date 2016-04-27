class QuizPagesController < ApplicationController
	helper_method :grade

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

		#get the userQuiz time started value
		#get the time allowed for the quiz value
		#if the time expired already then start a new attempt and a new time
		#else don't start a new attempt and resume the time
		@time_last_started = @userQuiz.time_started

		if @time_last_started
			#user has taken this quiz before, check to see if they are in the same attempt
			@time_allowed = @quiz.time_allowed
			@time_due_to_finish = @time_last_started + @time_allowed*60


			if @userQuiz.attempt_submitted 
				#the last attempt was submitted so start a clean attempt
				#this is a clean attempt
				@userQuiz.attemptsTaken += 1
				@userQuiz.time_started = DateTime.now
				@userQuiz.attempt_submitted = false
	  			@userQuiz.save

			elsif @time_due_to_finish < DateTime.now
				#the last attempt 
				
				#this is a clean attempt
				@userQuiz.attemptsTaken += 1
				@userQuiz.time_started = DateTime.now
				@userQuiz.attempt_submitted = false
	  			@userQuiz.save

			else
				#user is still taking quiz
			end
		else
			#the user has never taken the quiz before
			#this is a clean attempt
			@userQuiz.attemptsTaken += 1
			@userQuiz.time_started = DateTime.now
			@userQuiz.attempt_submitted = false
	  		@userQuiz.save
		end

		

  		@time_started = @userQuiz.time_started
  		@time_allowed = @quiz.time_allowed
	end

	def show
		@userQuiz = UserQuiz.find(params[:id])
        @quiz = Quiz.find(@userQuiz.quiz_id)
        @direction = Direction.find(@quiz.language.direction_id).directionCode 
        @results = Result.where("user_quiz_id = ?", @userQuiz.id)
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
		@userQuiz.attempt_submitted = true
		@userQuiz.save

		#an attempt is being saved, it is possible that data from previous attempts still exists
		#before saving anything new wipe existing results from the db
		@oldResults = Result.where("user_quiz_id = ?", @userQuiz.id)
		@oldResults.each do |oldResult|
			oldResult.destroy
		end

		if answers 
			answers.values.each do |answer|
				@answer = answer ? Answer.find(answer) : nil
				Result.create(
				    :user_quiz_id => @userQuiz.id, 
				    :chosen_answer => @answer.id,
				    :question_id => @answer.question_id)
			end
		else
			#every answer submitted was nil
			@quiz = Quiz.find(@userQuiz.quiz_id)
			@quiz.questions.each do |question|
				Result.create(
				    :user_quiz_id => @userQuiz.id, 
				    :chosen_answer => nil,
				    :question_id => question.id)
			end
		end

		

		redirect_to root_path
	end

	 def grade(userQuizId) #also in user quizzes controller
        @userQuiz = UserQuiz.find(userQuizId)
        @quiz = Quiz.find(@userQuiz.quiz_id)
        @noQuestions = @quiz.links.length
        @results = Result.where("user_quiz_id = ?", @userQuiz.id)

        @i = 0

        @results.each do |result|
            if result.chosen_answer != nil
                @answer = Answer.find(result.chosen_answer)
                if @answer.isCorrect
                    @i += 1
                end
            end
        end

        return @i * 100 / @noQuestions
    end


end
