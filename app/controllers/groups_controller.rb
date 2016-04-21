class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
	def index
		@groups = Group.where("staff_id = ?", current_user.id)
	end

	def show
    	@group = Group.find(params[:id])
      @members = @group.members
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
    		redirect_to add_members_groups_path(@group.id)
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

  def upload
    @group = Group.find(params[:id])
    uploaded_io = params[:file].tempfile
    csv_text = File.read(uploaded_io)
    
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      #for each row check to see if this user exists already
      user = User.where(email: row["Email"])
      if user.count == 1
        #the user already exists so simply create them as a member of this group
        Member.create(
          :student_id => user.first.id, 
          :group_id => @group.id)
      else
        #the user doesn't exist so they must be added to the user table and then added
        #as a member of this group
          @newUser = User.create!(
          :email => row["Email"],
          :username => row["Student Username"],
          :uid => row["Student Username"],
          :mail => row["Email"],
          :sn => row["Surname"],
          :givenname => row["Forename"],
          :role => "student")
        Member.create(
          :student_id => @newUser.id, 
          :group_id => @group.id)
      end
    end
    redirect_to @group
  end

  def add_members
    @group = Group.find(params[:id])
  end

	private
  		def group_params
    		params.require(:group).permit(:name, :file)
  		end

end
