class QuizzesController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource

    def index
        @noQuizzes = 0
        #@quizzes = Quiz.where("user_id = ?", current_user.id).paginate(:page => params[:page], :per_page => 10)
        @q = Quiz.where("quizzes.user_id = ?", current_user.id).search(params[:q])
        @q.sorts = 'language_languageName asc' if @q.sorts.empty?
        @quizzes = @q.result.paginate(:page => params[:page], :per_page => 8)

        @quizzes.each do |quiz|
            if UserQuiz.where("quiz_id=?", quiz.id).blank?
                @noQuizzes += 1
            end
        end
    end
    
    def show
        @quiz = Quiz.find(params[:id])

        if @quiz.language != nil
            @language = @quiz.language.languageName
        else 
            @language = 'Undefined'
        end
        @direction = Direction.find(@quiz.language.direction_id).directionCode
    end
    
    def new
        @quiz = Quiz.new
        @categories = Category.where("user_id = ?", current_user.id)
        if @categories.first == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a question before you can create a quiz" }
            return
        end


        @questions = Question.where("user_id = ?", current_user.id).where("category_id = ?", @categories.first.id)
        if @questions.first == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a question before you can create a quiz" }
            return
        end

        @link = Link.new
        @no_questions = 0
        @answers = Answer.where("question_id = ?", @questions.first.id)
        
        if @quiz.language_id
            @language = Language.find(@quiz.language_id)
        else
            @language = Language.where("user_id = ?", current_user.id).first
        end

        #If a language or category doesn't exist then this must be created before going to this page
        if @language == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a language before you can create a quiz" }
        end
        @direction = Direction.find(@language.direction_id).directionCode 
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
        @direction = Direction.find(@language.direction_id).directionCode 


    end
    
    def create
        @quiz = Quiz.new(quiz_params)
        @language = @quiz.language
        @quiz.user = current_user
        
        if @quiz.save
            redirect_to @quiz
        else
            render 'new'
        end
    end
    
    def update
        @quiz = Quiz.find(params[:id])
        @language = Language.find(@quiz.language_id)
        if @quiz.update(quiz_params)
            redirect_to @quiz
        else
            render 'edit'
        end
    end
    
    def destroy
        @quiz = Quiz.find(params[:id])
        @quiz.destroy

        if @quiz.destroyed?
            redirect_to quizzes_path
        else
            redirect_to quizzes_path, :flash => { :danger => "Error: #{@quiz.errors[:base][0].to_s}" }
        end
    end

    def take
    end

    def update_quizzes_direction
        @language = Language.find(params[:language_id])
        @direction = Direction.find(@language.direction_id).directionCode 
        respond_to do |format|
          format.js 
        end
    end

    
    private
        def quiz_params
            params.require(:quiz).permit(:title, :description, 
                :instructions, :attemptsAllowed, :shuffleQuestions, :shuffleAnswers, :time_allowed, :language_id, :user, links_attributes: [:id, :quiz_id, :question_id, :question_category, :_destroy], 
                questions_attributes: [:category_id, :body])
        end
    
end
