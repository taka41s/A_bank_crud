require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = User.create!({id: 1, email: 'test', password: 'test', current_balance: 2000.0})
    post(login_path, params: {user: {email: 'test', password: 'test'}})
  end

  describe "POST /login" do
    it "try to create a session" do
      post(login_path, params: {user: {email: 'test', password: 'test'}})
      expect(response).to have_http_status(302)
    end
  end

  describe "POST /close_account" do
    it "try to create a session" do
      get(close_account_path)
      expect(response).to have_http_status(302)
    end
  end
end
