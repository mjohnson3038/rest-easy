class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    begin
      @current_user ||= Merchant.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      @current_user = nil
    end
  end

end
