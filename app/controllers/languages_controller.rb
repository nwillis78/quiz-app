class LanguagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
	def index
		@languages = Language.where("user_id = ?", current_user.id)
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
      @language.user = current_user
 
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
    		render 'edit', :flash => { :danger => "Error: #{@language.errors[:base][0].to_s}" } 
  		end
	end

	def destroy
  		@language = Language.find(params[:id])
  		@language.destroy
 
  		if @language.destroyed?
            redirect_to languages_path
        else
            redirect_to languages_path, :flash => { :danger => "Error: #{@language.errors[:base][0].to_s}" }
        end
	end

	private
  		def language_params
    		params.require(:language).permit(:languageName, :direction_id, :user)
  		end
end
