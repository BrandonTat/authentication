class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
    else
      redirect_to new_user_url
    end
  end

  def new
  end

  def update
  end

  def destroy

  end

  def show
    redirect_to cats_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
