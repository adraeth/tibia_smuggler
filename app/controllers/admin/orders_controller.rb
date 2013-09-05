class Admin::OrdersController < ApplicationController

  before_action :signed_in_user
  before_action :authorize

  def index
    @orders = Order.includes(:user, :order_status, :world_to, :world_from)
  end

  def reject

  end

  def accept

  end

  def complete

  end

  private

    def authorize
      redirect_to(root_url) unless current_user.can_process_orders?
    end
end