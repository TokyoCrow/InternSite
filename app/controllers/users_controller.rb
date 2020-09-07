class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create]

	def new
    @user = User.new
	end

  def edit
		@user = User.find(current_user.id)
	end

	def update
  		@user = User.find(current_user.id)
  		if @user.update(user_params)
    		redirect_to root_path
 		else
   			render 'edit'
  		end
	end

	def create
	  @user = User.new(user_params)
	  if @user.save
      	log_in @user
      	redirect_to root_path
    else
      render "new"
    end
	end


	private

  	def user_params
      return params.require(:user).permit(:email, :password, :name, :password_confirmation)
  	end
end
