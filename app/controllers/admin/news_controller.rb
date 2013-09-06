class Admin::NewsController < ApplicationController

  before_action :signed_in_user
  before_action :authorize

  def new
    @news = News.new
  end

  def create
    @news = News.create(params[:news])
    if @news.save
      redirect_to @news
    else
      render 'admin/news/new'
    end
  end

  def index

  end

  private

    def authorize
      redirect_to(root_url) unless current_user.can_manage_news?
    end
end