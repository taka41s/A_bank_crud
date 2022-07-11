class ApplicationController < ActionController::Base
    helper_method :current_user
    
    def current_user
        if session[:user_id]
          @current_user ||= User.find(session[:user_id])
        end
    end

    def user_signed_in
      current_user.present?
    end

    protected
    def authenticate_user!
      if user_signed_in
      else
        redirect_to login_path, :notice => 'NOT AUTHENTICATED'
      end
    end
end
