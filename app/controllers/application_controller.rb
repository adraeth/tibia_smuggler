class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ReferrersHelper
  include RatesHelper
  include WorldsHelper
end
