class Admin::WorldsController < ApplicationController

  before_action :signed_in_user
  before_action :authorize
  before_action :find_world, only: [:toggle_incoming_lock, :toggle_outgoing_lock, :edit_amount]

  def index
    @worlds = World.all.to_a
  end

  def toggle_outgoing_lock
    @world.blocked_for_outgoing = !@world.blocked_for_outgoing
    @world.save
    render json: {status: 'completed'}
  end
  
  def toggle_incoming_lock
    @world.blocked_for_incoming = !@world.blocked_for_incoming
    @world.save
    render json: {status: 'completed'}
  end

  def edit_amount
    @world.amount += params[:amount].to_i
    @world.save
    render json: {status: 'completed', amount: @world.reload.amount}
  end

  private

    def find_world
      @world = World.find(params[:id])
    end

    def authorize
      redirect_to(root_url) unless current_user.can_manage_worlds?
    end
end