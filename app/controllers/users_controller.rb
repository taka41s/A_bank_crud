class UsersController < ApplicationController
	def new
			@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to '/register', {
			notice: 'O usuário foi criado com sucesso.',
			}
		else
			redirect_to '/register', {
			notice: 'Verifique suas informacoes e tente novamente.',
			}
		end
	end

	def edit_account

	end

	def close_account
		@user_disabled_account = true
	end


	private

	def user_params
			params.require(:user).permit(:email, :password)
	end

end
