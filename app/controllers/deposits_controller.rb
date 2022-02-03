class DepositsController < ApplicationController
    def new
        @Deposit = Deposit.new
    end

    def create
        @deposit = Deposit.new(user_params)
        @deposit.user_id = current_user.id

        if @deposit.save
            flash[:notice] = 'Sent.'
            @User = User.find_by(email: current_user.email)
            @Deposit = Deposit.new(user_params)
            @Deposit.transaction do
                @Deposit.save
                @User.update_attribute(:current_balance, @User.current_balance + @Deposit.amount)
            end
        else
            flash[:notice] = 'Something went wrong'
            render :new
        end
    end

    def show
        @deposits = Deposit.where(user_id: current_user)
        render :historic
    end


    private
    def user_params
        params.require(:user).permit(:bank_account, :amount)
    end
end
