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
        @categories = Category.where("user_id = ?", current_user.id)
        if @categories.first == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a question before you can create a quiz" }
            return
        end


        @questions = Question.where("category_id = ?", @categories.first.id)
        if @questions.first == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a question before you can create a quiz" }
            return
        end

        @link = Link.new
        @no_questions = 0

        if @questions.first != nil
            @answers = Answer.where("question_id = ?", @questions.first.id)
        else
            @answers = nil
        end

        if @quiz.language_id
            @language = Language.find(@quiz.language_id)
        else
            @language = Language.where("user_id = ?", current_user.id).first
        end

        #If a language or category doesn't exist then this must be created before going to this page
        if @language == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a language before you can create a quiz" }
        end
    end
    
    def edit
        @quiz = Quiz.find(params[:id])
        @questions = Question.where("category_id = ?", Category.where("user_id = ?", current_user.id).first.id)
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
