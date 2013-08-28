class RatesController < ApplicationController
  def show
    @rate = rate_for(params)
    render json: @rate.to_json( only: [:rate, :reducible, :reduction_step])
  end
end
