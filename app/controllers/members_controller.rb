class MembersController < ApplicationController
	before_filter :authenticate_user!
  	load_and_authorize_resource

	def new
		@member = Member.new
	end

	def create
  		@member = Member.new(member_params)
  		@member.save
	end

	def destroy
  		@member = Member.find(params[:id])
  		@member.destroy
	end

	private
  		def member_params
    		params.require(:member).permit(:student_id, :group_id)
  		end
end
