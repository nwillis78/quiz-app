class UsersController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource

	def index
		@users = User.all
	end

	def create
		@user = User.new(user_params)
        @user.save
	end

	private
  		def user_params
    		params.require(:user).permit(:email, :username, :uid, :mail, :sn, :givenname, :role)
  		end
end
