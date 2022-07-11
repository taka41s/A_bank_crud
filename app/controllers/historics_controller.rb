class HistoricsController < ApplicationController
  before_action :authenticate_user!
  def index
    render :home
  end

  def deposits_history
    @deposits = Deposit.where(user_id: current_user.id)

    render :deposits
  end

  def transactions_history
    @transactions = Transaction.where(user_id: current_user.id)

    render :transactions
  end

  def withdraws_history
    @withdraw = Withdraw.where(user_id: current_user.id)

    render :withdraws
  end
end
