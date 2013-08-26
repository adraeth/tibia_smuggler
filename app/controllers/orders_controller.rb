class OrdersController < ApplicationController

  before_filter :get_news, only: [:new, :create]

  def get_news
    @news = News.visible.latest
  end

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

  def show

  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order].except(:world_from_id, :world_to_id))
      #success
    else
      #failure
    end
  end
end
