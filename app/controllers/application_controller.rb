class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def current_user
        if session[:user_id]
          @current_user ||= User.find(session[:user_id])
        end
    end

    def user_signed_in
      current_user.present? && current_user.disabled_account != true
    end

    protected
    def authenticate_user!
      if user_signed_in
      else
        if current_user.nil?
          redirect_to login_path, :notice => 'You need to login'
        else
          redirect_to login_path, :notice => 'Account disabled'
        end
      end
    end
end
