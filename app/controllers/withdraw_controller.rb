class WithdrawController < ApplicationController
    before_action :authenticate_user!

    def new
        @withdraw = Withdraw.new
    end

    def create
        @user = current_user

        @withdraw = Withdraw.new(user_params)
        @withdraw.user_id = @user.id

        amount = params[:user][:amount].to_f
        if amount <= @user.current_balance
            @withdraw.transaction do
                @user.update_attribute(:current_balance, @user.current_balance - amount)
                @user.update_attribute(:wallet_balance, @user.wallet_balance + amount)
                @withdraw.save && @user.save
            end
        else
            flash.now[:error] = 'Invalid amount'
        end
    end
    
    def show
        @withdraw = Withdraw.where(user_id: current_user.id)
        render :withdraw_historic
    end
end

    private
    def user_params
        params.require(:user).permit(:amount)
    end