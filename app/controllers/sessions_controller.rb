class SessionsController < ApplicationController
  def create
    login_user!
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end

  def new
  end
end
