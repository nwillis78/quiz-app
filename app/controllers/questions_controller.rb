class QuestionsController < ApplicationController
    before_filter :authenticate_user!
    load_and_authorize_resource
    
    def index
        @questions = Question.where("user_id = ?", current_user.id)
    end
    
    def show
        @question = Question.find(params[:id])
  
        if @question.category != nil
            @category = @question.category.categoryBody
        else 
            @category = 'Undefined'
        end

        if @question.language != nil
            @language = @question.language.languageName
        else 
            @language = 'Undefined'
        end
    end
    
    def new
        @question = Question.new
        @question.build_category

        if @question.category_id
            @category = Category.find(@question.category_id)
        else
            @category = Category.where("user_id = ?", current_user.id).first
        end

        if @question.language_id
            @language = Language.find(@question.language_id)
        else
            @language = Language.where("user_id = ?", current_user.id).first
        end
        
        #If a language or category doesn't exist then this must be created before going to this page
        if @category == nil && @language == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a category and a language before you can create a question" }
        elsif @category == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a category before you can create a question" }
        elsif @language == nil
            redirect_to category_questions_path(Question.all), :flash => { :warning => "You must create a language before you can create a question" }
        end
        
    end
    
    def edit
        @question = Question.find(params[:id])
        @category = Category.find(@question.category_id)
        @language = Language.find(@question.language_id)
    end
    
    def create
        @question = Question.new(question_params)
        @category = Category.find(@question.category_id)  
        @language = Language.find(@question.language_id)
        @question.user = current_user
        
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
        #use the special question_params_no_answers private method to create a dummy question using
        #the fields from the form. This method is used as appose to the standard question_params
        #because we do not need the answer data here - this question is only created to obtain the 
        #category id
        @question_edit = Question.new(question_params_no_answers)
        @category = Category.find(@question_edit.category_id)

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

        if @question.destroyed?
            redirect_to category_questions_path(@questions)
        else
            redirect_to category_questions_path(@questions), :flash => { :danger => "Error: #{@question.errors[:base][0].to_s}" }
        end
        
    end 

    def update_questions
        @questions = Question.where("category_id = ?", params[:ajax_category_id])
        @question_no = params[:question_no]

        respond_to do |format|
          format.js 
        end
    end  

    def show_questions
        @question = Question.find_by("id = ?", params[:links][:category_id])
    end
    
    private
        def question_params
            params.require(:question).permit(:category_id, :language_id, :body, :user, 
                answers_attributes: [:id, :answerString, :isCorrect, :_destroy])
        end

        def question_params_no_answers
            params.require(:question).permit(:category_id, :body)
        end

end
