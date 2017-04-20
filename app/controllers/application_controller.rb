class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    current_user = User.find_by(session_token: session[:session_token])
  end

  def login_user!
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      session[:session_token] = @user.generate_session_token
      redirect_to cats_url
    else
      flash[@user.errors.full_messages]
      redirect_to new_session_url
    end
  end
end
# at this point, you should probably factor out the login code from
# SessionsController#create into an ApplicationController#login_user!
#  method so that you can use it in UsersController for this purpose.
