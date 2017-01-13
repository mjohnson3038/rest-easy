class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:index, :create]

  def create
    auth_hash = request.env['omniauth.auth']
    redirect_to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'google')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_google(auth_hash)
      render :creation_failure unless @user.save
    end

    # Save the user ID in the session
    session[:user_id] = @user.id
    redirect_to receipts_path
  end

  def index
    if session[:user_id].nil?
      redirect_to login_failure_path
    else
      @user = User.find(session[:user_id]) # < recalls the value set in a previous request
    end
  end

  def login_failure; end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
