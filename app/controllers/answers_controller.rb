class AnswersController < ApplicationController
    def show
    end

    def new
        question = @answer.build_profile
    end
    
    def edit
        
    end
    
    def create
        @question = Question.find(params[:question_id])
        @answer = @question.answers.create(answer_params)
        redirect_to question_path(@quesiton)
    end
    
    def update
        
    end
    
    def destroy
        @question = Question.find(params[:question_id])
        @answer = @question.comments.find(params[:id])
        @answer.destroy
        redirect_to question_path(@question)
    end

    def update_answers
        @answers = Answer.where("question_id = ?", params[:question_id])
        respond_to do |format|
          format.js
        end
    end  
    
    private
        def answer_params
            params.require(:answer).permit(:answerString, :isCorrect)
        end
end
