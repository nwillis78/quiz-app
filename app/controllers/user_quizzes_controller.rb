class UserQuizzesController < ApplicationController
    
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

    private
        def user_quiz_params
            params.require(:user_quiz).permit(:quiz_id, :student_id)
        end
end
