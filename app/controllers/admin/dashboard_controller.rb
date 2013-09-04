class Admin::DashboardController < ApplicationController

  before_action :signed_in_user
  before_action :authorize

  def index
  end

  private

    def authorize
      redirect_to(root_url) unless current_user.can_access_admin_panel?
    end
end
