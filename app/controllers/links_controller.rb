class LinksController < ApplicationController
	before_filter :authenticate_user!
	
	def create
		@link = Link.new(link_params)
        @link.save
	end

	private
        def link_params
            params.require(:link).permit(:quiz_id, :question_category, :question_id, questions_attributes: [:category_id, :body])
        end
end
