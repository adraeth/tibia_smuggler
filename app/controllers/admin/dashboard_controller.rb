class Admin::DashboardController < ApplicationController

  before_action :signed_in_user
  before_action :authorize

  def index
    @orders_last_month = Order.created_last_month.to_a
    @orders_this_month = Order.created_this_month.to_a
    @orders = Order.all.to_a
  end

  private

    def authorize
      redirect_to(root_url) unless current_user.can_access_admin_panel?
    end
end
