class TransactionsController < ApplicationController
    before_action :authenticate_user!

    def new
        @transaction = Transaction.new
        @target_user = User.new
    end

    def create
        @user = User.find_by(id: current_user.id)

        @target_user = User.find_by(email: user_params[:to_user])
        amount = user_params[:amount].to_i

        if amount <= @user.current_balance
            amount - tax
            @user.update_attribute(:current_balance, @user.current_balance - amount)
            @target_user.update_attribute(:current_balance, @target_user.current_balance + amount)

            redirect_to '/transactions', {
                notice: 'transaction done successfuly',
            }
        else
            redirect_to '/transactions', {
                notice: 'Not enough balance',
            }
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

    def show
        @overview = Transaction.where(user_id: current_user.id)
        render :overview
    end


    private

    def user_params
        params.require(:user).permit(:to_user, :amount)
    end
end
