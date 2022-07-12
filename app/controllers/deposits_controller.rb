class DepositsController < ApplicationController
    before_action :authenticate_user!

    def new
        @deposit = Deposit.new
    end

    def create
        @deposit = Deposit.new(user_params)
        @deposit.user_id = current_user.id

        if @deposit.save
            @user = User.find_by(email: current_user.email)
            @deposit = Deposit.new(user_params)
            amount = params[:user][:amount].gsub(/[\s,]/ ,"").to_f
            @deposit.transaction do
                @deposit.save
                @user.update_attribute(:current_balance, @user.current_balance + amount)
            end
            redirect_to '/deposit', {
                notice: 'Sent.',
            }
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
        params.require(:user).permit(:amount)
    end
end
