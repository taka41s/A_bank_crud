require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  before do
    @user = User.create!({id: 1, email: 'test', password: 'test', current_balance: 2000.0})
    post(login_path, params: {user: {email: 'test', password: 'test'}})
  end

  describe "POST /transactions" do
    it "transactions working" do
      user_params = {
        amount: 500.0,
      }
      post(withdraw_path, params: {user: user_params})
      @user.reload
      expect(response).to have_http_status(302)
      expect(@user.wallet_balance).to eq(500.0)
      expect(@user.current_balance).to eq(1500.0)
    end
  end
end