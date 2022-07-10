class UsersController < ApplicationController
	def new
			@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to '/register', {
			notice: 'User created successfuly.',
			}
		else
			redirect_to '/register', {
			notice: 'Verify your informations and try again.',
			}
		end
	end

	def edit_account

	end

	def close_account
		user = @current_user
		byebug

		if @user.save
			redirect_to '/login', {
				notice: 'Your account was succesfuly closed.',
			}
		else
		redirect_to '/login', {
			notice: 'Something goes wrong.',
			}
		end
	end


	private

	def user_params
			params.require(:user).permit(:email, :password)
	end

end
