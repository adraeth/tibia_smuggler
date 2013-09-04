class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ReferrersHelper
  include RatesHelper
  include WorldsHelper

  def signed_in_user
    redirect_to login_url, notice: 'Please log in.' unless signed_in?
  end
end
