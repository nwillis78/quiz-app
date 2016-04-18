class ResultsController < ApplicationController
	def new
		@result = Result.new
	end

	def create
        @result = Result.new(result_params)
        @result.save
    end

    def destroy
        @result = Result.find(params[:id])
        @result.destroy
        
        if @result.destroyed?
            redirect_to root_path
        else
            redirect_to root_path, :flash => { :danger => "Error: #{@category.errors[:base][0].to_s}" }
        end
    end



    private
    	def result_params
            params.require(:result).permit(:user_quiz_id, :chosen_answer, :question_id)
        end

end
