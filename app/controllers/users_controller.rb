class UsersController < ApplicationController

  before_action :signed_in_user, only: [:show, :update]
  before_action :correct_user, only: [:show, :update]

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
    @orders = current_user.orders.to_a
  end

  def update
    if @user.update_attributes(params[:user].except!(:name))
      sign_in(@user)
      flash[:info] = 'Your profile was successfully updated.'
      redirect_to @user
    else
      flash.now[:error] = 'Please enter a correct email and password (you can re-type your old password)'
      @orders = current_user.orders.to_a
      render 'users/show'
    end
  end

    private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
