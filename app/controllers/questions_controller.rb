class QuestionsController < ApplicationController
    
    def index
        @questions = Question.all
    end
    
    def show
        @question = Question.find(params[:id])
  
        if @question.category != nil
            @category = @question.category.categoryBody
        else 
            @category = 'Undefined'
        end
    end
    
    def new
        @question = Question.new
        @category = Category.first
    end
    
    def edit
        @question = Question.find(params[:id])
        @category = @question.category
    end
    
    def create
        @question = Question.new(question_params)
        @category = Category.find(params[:category_id])
        
        if @question.save
            redirect_to category_question_path(@question.category_id, @question)
        else
            respond_to do |format|
                format.html { render :template => "questions/new" }
            end
        end
    end
    
    def update
        @question = Question.find(params[:id])
        @category = Category.find(params[:category_id])

        if @question.update(question_params)
            redirect_to category_question_path(@question.category_id, @question)
        else
            respond_to do |format|
                format.html { render :template => "questions/edit" }
            end
            
        end
    end
    
    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        @questions = Question.all
        
        redirect_to category_questions_path(@questions)
    end 

    def update_questions
        @questions = Question.where("category_id = ?", params[:category_id])
        respond_to do |format|
          format.js
        end
    end  

    def show_questions
        @question = Question.find_by("id = ?", params[:links][:category_id])
    end
    
    private
        def question_params
            params.require(:question).permit(:category_id, :body, answers_attributes: [:id, :answerString, :isCorrect, :_destroy])
        end

       
    
end
