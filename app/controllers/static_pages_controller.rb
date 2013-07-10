class StaticPagesController < ApplicationController
  def home
    @news = News.visible.latest
    @order = Order.new
  end

  def help
  end

  def gold_list
  end
end
