class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
	def index
		@groups = Group.where("staff_id = ?", current_user.id)
	end

	def show
    	@group = Group.find(params[:id])
  	end

	def new
		@group = Group.new
	end

	def edit
  		@group = Group.find(params[:id])
	end

	def create
  		@group = Group.new(group_params)
      	@group.staff_id = current_user.id
 
  		if @group.save
    		redirect_to @group
  		else
    		render 'new'
  		end
	end
 
	def update
  		@group = Language.find(params[:id])
 
  		if @group.update(group_params)
    		redirect_to @group
  		else
    		render 'edit', :flash => { :danger => "Error: #{@group.errors[:base][0].to_s}" } 
  		end
	end

	def destroy
  		@group = Group.find(params[:id])
  		@group.destroy
 
  		if @group.destroyed?
            redirect_to groups_path
        else
            redirect_to groups_path, :flash => { :danger => "Error: #{@group.errors[:base][0].to_s}" }
        end
	end

	private
  		def group_params
    		params.require(:group).permit(:name)
  		end

end
