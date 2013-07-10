class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.save_signup_ip request.remote_ip
    if @user.save
      sign_in(@user)
      redirect_to @user
    else
      render 'sessions/new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
