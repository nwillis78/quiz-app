class UserQuizzesController < ApplicationController
    helper_method :grade
    
	def new
		@user_quiz = UserQuiz.new
		if @user_quiz.quiz_id
            @quiz = Quiz.find(@user_quiz.quiz_id)
        else
            @quiz = Quiz.where("user_id = ?", current_user.id).first
        end
        #If a quiz doesn't exist then this must be created before going to this page
        if @quiz == nil
            redirect_to root_path, :flash => { :warning => "You must create a quiz before you can set it" }
        end
	end

	def create
        @user_quiz = UserQuiz.new(user_quiz_params)
        @user_quiz.staff_id = current_user.id
        @user_quiz.attemptsTaken = 0
        if @user_quiz.quiz_id
            @quiz = Quiz.find(@user_quiz.quiz_id)
        else
            @quiz = Quiz.where("user_id = ?", current_user.id).first
        end
        
        if @user_quiz.save
            redirect_to @user_quiz
        else
            render 'new'
        end
    end

    def show
    	@user_quiz = UserQuiz.find(params[:id])
    end

    def edit
        @user_quiz = UserQuiz.find(params[:id])
        if @user_quiz.quiz_id
            @quiz = Quiz.find(@user_quiz.quiz_id)
        else
            @quiz = Quiz.where("user_id = ?", current_user.id).first
        end
    end

    def update
        @user_quiz = UserQuiz.find(params[:id])
        
        if @user_quiz.update(user_quiz_params)
            redirect_to @user_quiz
        else
            render 'edit'
        end
    end

    def grade(userQuizId)
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

    def student_detail
        @userQuiz = UserQuiz.find(params[:id])
        @quiz = Quiz.find(@userQuiz.quiz_id)
        @direction = Direction.find(@quiz.language.direction_id).directionCode 
        @results = Result.where("user_quiz_id = ?", @userQuiz.id)
    end

    private
        def user_quiz_params
            params.require(:user_quiz).permit(:quiz_id, :student_id, :start_date, :end_date, :attemptsTaken)
        end
end
