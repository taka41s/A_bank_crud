class TransactionsController < ApplicationController
    def new
        @Transaction = Transaction.new
        @Target_user = User.new
    end


    def create
        @User = User.find_by(email: current_user.email)
        @Target_user = User.find_by(email: user_params[:to_user])
        @transaction = Transaction.new(user_params)
        @transaction.user_id = current_user.id
        @transaction.from_user = current_user.email
        @transaction.to_user = @Target_user.email
        if @transaction.amount <= @User.current_balance
            @User.save && @Target_user.save && @transaction.save
            @User.update_attribute(:current_balance, @User.current_balance - @transaction.amount)
            @Target_user.update_attribute(:current_balance, @Target_user.current_balance + @transaction.amount)
        end

    end

    def show
        @overview = Transaction.where(user_id: current_user.id)
        render :overview
    end


    private

    def user_params
        params.require(:user).permit(:to_user, :amount)
    end
end