module SessionsHelper

  def login_by_email?(email)
    email.include? "@"
  end

  def user_for(email)
    if login_by_email? email
      User.find_by(email: params[:session][:email].downcase)
    else
      Rails.env.production? ? query = 'name ILIKE ?' : query = 'name LIKE ?'
      User.where(query, params[:session][:email]).first
    end
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def failed_login_with_message(message)
    LoginAttempt.create(ip: request.remote_ip, login: params[:session][:email])
    flash.now[:error] = message
    render 'sessions/new'
  end
end
