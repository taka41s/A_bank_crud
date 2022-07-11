require 'rails_helper'

RSpec.describe "Deposits", type: :request do
  before do
    @user = User.create!({id: 1, email: 'test', password: 'test', current_balance: 2000.0})
    @target_user = User.create!({id: 2, email: 'test2', password: 'test2', current_balance: 2000.0})
    current_user = create_session(current_user: @user)
    post(login_path, params: {user: {email: 'test', password: 'test'}})
  end

  describe "POST /deposit" do
    it "sum amount with current balance, if pass deposits#create works" do
      user_params = {
        amount: 500.0,
      }
      post(deposit_path, params: {user: user_params})
      @user.reload
      @target_user.reload
      expect(response).to have_http_status(302)
      expect(@user.current_balance).to eq(2500.0)
    end
  end
end
