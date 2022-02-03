class WithdrawController < ApplicationController
    def new
        @Withdraw = Withdraw.new
    end

    def create
        @User = User.find_by(email: current_user.email)
        @Withdraw = Withdraw.new(user_params)
        @Withdraw.user_id = current_user.id
        if @Withdraw.amount <= @User.current_balance
            @Withdraw.transaction do
                @Withdraw.save
                @User.update_attribute(:current_balance, @User.current_balance - @Withdraw.amount)
                @User.update_attribute(:wallet_balance, @User.wallet_balance + @Withdraw.amount)
            end
        else
            flash.now[:error] = 'Invalid amount'
        end
    end
    
    def show
        @Withdraw = Withdraw.where(user_id: current_user.id)
        render :withdraw_historic
    end
end

    private
    def user_params
        params.require(:user).permit(:amount)
    end