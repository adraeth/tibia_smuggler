class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    @user.save_signup_ip request.remote_ip
    if @user.save
      sign_in(@user)
      if session[:order].nil?
        redirect_to @user
      else
        redirect_to confirm_order_path
      end
    else
      render 'sessions/new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
