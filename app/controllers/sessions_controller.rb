class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new

    user = user_for(params[:session][:email])

    if LoginAttempt::allowed?(request.remote_ip)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        if session[:order]
          redirect_to confirm_order_path
        else
          redirect_to user
        end
      else
        failed_login_with_message('Invalid login data!')
      end
    else
      failed_login_with_message('You have exceeded the limit of 5 allowed failed login attempts')
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end
end
