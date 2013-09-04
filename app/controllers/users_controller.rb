class UsersController < ApplicationController

  before_action :signed_in_user, only: :show
  before_action :correct_user, only: :show

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
  end

    private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
