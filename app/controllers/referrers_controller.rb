class ReferrersController < ApplicationController
  def save
    referrer = referrer_as_user_for(params[:referrer]) # May return nil!
    session[:referrer] = referrer.id if referrer
    flash[:no_referrer] = 'User specified as your referrer could not be found!' unless referrer
    redirect_to root_path
  end
end