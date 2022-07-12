class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.find_by(email: user_params[:email])

        if @user && @user.is_password?(user_params[:password])
            session[:user_id] = @user.id
            redirect_to '/deposit'
        elsif @user.disabled_account.present?
            flash.now[:notice] = 'Account disabled'
            render :new
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

    def logout
        session.clear
        redirect_to '/login', {
            notice: 'Logout.',
        }
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
