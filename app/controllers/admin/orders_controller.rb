class Admin::OrdersController < ApplicationController

  before_action :signed_in_user
  before_action :authorize
  before_action :find_order, only: [:destroy, :accept, :complete]

  def index
    @orders = Order.includes(:user, :order_status, :world_to, :world_from)
  end

  def destroy
    @order.destroy('cancelled by admin') if current_user.can_process_orders?
    redirect_to admin_orders_path
  end

  def accept
    @order.accept
    redirect_to admin_orders_path
  end

  def complete
    @order.complete if current_user.can_process_orders?
    redirect_to admin_orders_path
  end

  private

    def authorize
      redirect_to(root_url) unless current_user.can_process_orders? || current_user.can_accept_orders?
    end

    def find_order
      @order = Order.find(params[:id])
    end
end