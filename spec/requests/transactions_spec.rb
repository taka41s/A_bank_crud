require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  before do
    @user = User.create!({id: 1, email: 'test', password: 'test', current_balance: 2000.0})
    @target_user = User.create!({id: 2, email: 'test2', password: 'test2', current_balance: 2000.0})
    post(login_path, params: {user: {email: 'test', password: 'test'}})
  end

  describe "POST /transactions" do
    it "transactions working" do
      user_params = {
        to_user: @target_user.email,
        amount: 500.0,
      }
      post(transactions_path, params: {user: user_params})
      @user.reload
      @target_user.reload
      expect(response).to have_http_status(302)
      expect(@user.current_balance).to eq(1500.0)
      expect(@target_user.current_balance).to eq(2500.0)
    end
  end
end
