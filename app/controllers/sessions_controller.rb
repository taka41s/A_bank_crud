class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: user_params[:email])
        if @user && @user.is_password?(user_params[:password]) && @user.disabled_account != true
            session[:user_id] = @user.id
            redirect_to '/deposit'
        elsif @user.disabled_account == true
            redirect_to '/login', {
                notice: 'Account disabled'
            }
        else
            flash.now[:notice] = 'Invalid email or password'
            render :new
        end
    end

    def close_account
		user = current_user

		if user.save
            user.update(disabled_account: true)
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
