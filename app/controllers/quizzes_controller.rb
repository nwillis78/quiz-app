class QuizzesController < ApplicationController
    helper_method :get_selected_question

    def index
        @quizzes = Quiz.all
    end
    
    def show
        @quiz = Quiz.find(params[:id])
    end
    
    def new
        @quiz = Quiz.new
        @questions = Question.where("category_id = ?", Category.first.id)
        @answers = Answer.where("question_id = ?", @questions.first.id)
        @link = Link.new
        @no_questions = 0
    end
    
    def edit
        @quiz = Quiz.find(params[:id])
        @questions = Question.where("category_id = ?", Category.first.id)
    end
    
    def create
        @quiz = Quiz.new(quiz_params)
        
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
                :instructions, links_attributes: [:quiz_id, :question_id], 
                questions_attributes: [:category_id, :body])
        end
    
end
