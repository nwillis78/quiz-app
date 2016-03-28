class LanguagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
	def index
		@languages = Language.all
	end

	def show
    	@language = Language.find(params[:id])

    	if @language.direction_id != nil
            @direction = @language.direction.directionName
        else 
            @direction = 'Undefined'
        end
  	end

	def new
		@language = Language.new

		if @language.direction_id
            @direction = Direction.find(@language.direction_id)
        else
            @direction = Direction.first
        end
	end

	def edit
  		@language = Language.find(params[:id])
      @direction = Direction.find(@language.direction_id)
	end

	def create
  		@language = Language.new(language_params)
      @direction = Direction.find(@language.direction_id)
 
  		if @language.save
    		redirect_to @language
  		else
    		render 'new'
  		end
	end
 
	def update
  		@language = Language.find(params[:id])
      @direction = Direction.find(@language.direction_id)
 
  		if @language.update(language_params)
    		redirect_to @language
  		else
    		render 'edit'
  		end
	end

	def destroy
  		@language = Language.find(params[:id])
  		@language.destroy
 
  		redirect_to languages_path
	end

	private
  		def language_params
    		params.require(:language).permit(:languageName, :direction_id)
  		end
end
