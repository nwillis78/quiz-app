class QuizzesController < ApplicationController
    before_filter :authenticate_user!
    helper_method :get_selected_question
    load_and_authorize_resource


    def index
        @quizzes = Quiz.where("user_id = ?", current_user.id)
    end
    
    def show
        @quiz = Quiz.find(params[:id])

        if @quiz.language != nil
            @language = @quiz.language.languageName
        else 
            @language = 'Undefined'
        end
    end
    
    def new
        @quiz = Quiz.new
        @questions = Question.where("category_id = ?", Category.first.id)
        @answers = Answer.where("question_id = ?", @questions.first.id)
        @link = Link.new
        @no_questions = 0

        if @quiz.language_id
            @language = Language.find(@quiz.language_id)
        else
            @language = Language.first
        end
    end
    
    def edit
        @quiz = Quiz.find(params[:id])
        @questions = Question.where("category_id = ?", Category.first.id)
        @answers = Answer.where("question_id = ?", @questions.first.id)
        if @quiz.questions.first != nil
            @links = @quiz.questions
        else
            @link = nil
        end
        @no_questions = 0
        @language = Language.find(@quiz.language_id)
    end
    
    def create
        @quiz = Quiz.new(quiz_params)
        @quiz.user = current_user
        
        if @quiz.save
            redirect_to @quiz
        else
            render 'new'
        end
    end
    
    def update
        @quiz = Quiz.find(params[:id])
        
        @quiz.update(quiz_params)
        redirect_to @quiz
    end
    
    def destroy
        @quiz = Quiz.find(params[:id])
        @quiz.destroy
        
        redirect_to quizzes_path
    end

    
    private
        def quiz_params
            params.require(:quiz).permit(:title, :description, 
                :instructions, :language_id, :user, links_attributes: [:id, :quiz_id, :question_id, :question_category, :_destroy], 
                questions_attributes: [:category_id, :body])
        end
    
end
