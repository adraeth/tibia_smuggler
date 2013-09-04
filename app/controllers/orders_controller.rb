class OrdersController < ApplicationController

  before_action :get_news, only: [:new, :create]
  before_action :signed_in_user, only: [:index, :show, :destroy]
  before_action :correct_user, only: [:show, :destroy]

  def new
    @order = Order.new
  end

  def create
    if signed_in?
      params[:order] = session[:order] || params[:order]
      session[:order] = nil
      @order = current_user.orders.build(params[:order])
      if @order.save
        redirect_to @order # TODO: Change path a correct one
      else
        render 'orders/new'
      end
    else
      session[:order] = params[:order]
      flash[:notice] = 'You order details were saved. Please log in or create an account to confirm your order.'
      redirect_to login_path
    end
  end

  def index
    @orders = current_user.orders.includes(:user, :order_status, :world_to, :world_from)
  end

  def show

  end

  def destroy
    @order.destroy
    render 'show'
  end

    private

    def get_news
      @news = News.visible.latest
    end

    def signed_in_user
      redirect_to login_url, notice: 'Please log in.' unless signed_in?
    end

    def correct_user
      @order = Order.find(params[:id])
      redirect_to(root_url) unless current_user?(@order.user)
    end
end
