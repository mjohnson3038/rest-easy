class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  def user
    @user ||=User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to root_path
    end
  end

end
