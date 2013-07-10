class RatesController < ApplicationController
  def show
    sleep 0 if Rails.env.development?
    @rate = rate_for(params)
    render json: @rate.to_json( only: [:rate, :reducible, :reduction_step])
  end
end
