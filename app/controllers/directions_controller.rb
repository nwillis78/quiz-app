class DirectionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
	def index
    	@directions = Direction.all
  	end
    
	def new
	end

	def create
  		@direction = Direction.new(direction_params)
 
  		@direction.save
  		redirect_to @direction
	end

	def show
   		@direction = Direction.find(params[:id])
 	end

 	

	private
  		def direction_params
    		params.require(:direction).permit(:directionName, :directionCode)
  		end
end
