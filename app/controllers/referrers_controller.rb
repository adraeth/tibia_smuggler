class ReferrersController < ApplicationController
  def save
    referrer = referrer_as_user_for(params[:referrer])
    session[:referrer] = referrer.id if referrer
    redirect_to root_path
  end
end