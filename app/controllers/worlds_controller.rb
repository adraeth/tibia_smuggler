class WorldsController < ApplicationController
  def new
  end

  def create
  end

  def index
    @worlds = World.includes(:world_type).all
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
