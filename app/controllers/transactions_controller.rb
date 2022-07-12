class TransactionsController < ApplicationController
    before_action :authenticate_user!

    def new
        @transaction = Transaction.new
        @target_user = User.new
    end

    def create
        @user = User.find_by(id: current_user.id)
        @target_user = User.find_by(email: user_params[:to_user])
        amount = params[:user][:amount].gsub(/[\s,]/ ,"").to_f
        @transactions = Transaction.new(user_params)
        @transactions.user_id = current_user.id
        @transactions.from_user = current_user.email
        @transactions.transaction do 
            if amount <= @user.current_balance && @target_user.present?
                user_new_balance = @user.current_balance - amount
                target_user_new_balance = @target_user.current_balance + amount
                amount - tax

                @user.update(current_balance: user_new_balance)
                @target_user.update(current_balance: target_user_new_balance)
                @transactions.save
                redirect_to '/transactions', {
                    notice: 'transaction done successfuly',
                }
            elsif @target_user.present? != true
                redirect_to '/transactions', {
                    notice: 'User not found',
                }
            else
                redirect_to '/transactions', {
                    notice: 'Not enough balance',
                }
            end
        end
    end

    def tax
        if business_time
            tax = 5.0
        elsif business_time == false && params[:amount].to_i > 1000
            tax = 10.0
        else
            tax = 7.0
        end

        tax
    end

    def business_time
        weekend = current_day_of_week.saturday? || current_day_of_week.sunday? 
        start_time = Time.parse('2000-01-01T09:00:00Z').strftime('%H:%M:%S')
        end_time = Time.parse('2014-01-24T018:00:00').strftime("%H:%M:%S")
        current_time = Time.now.strftime("%H:%M:%S")

        if current_time.between?(start_time, end_time) && weekend == false
            business_time = true
        else 
            business_time = false
        end
        business_time
    end


    def current_day_of_week
        current_time = Time.now
        year = current_time.year
        month = current_time.month
        day = current_time.day
        date = Date.new(year, month, day)
    end

    private

    def user_params
        params.require(:user).permit(:to_user, :amount, :from_user, :user_id)
    end
end
