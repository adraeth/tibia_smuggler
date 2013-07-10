class NewsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @news = News.visible
  end

  def show
    @news = News.visible.find(params[:id])
  rescue
    redirect_to news_index_path
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
