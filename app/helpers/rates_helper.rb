module RatesHelper
  def rate_for(params)
    Rate.where(from_world_type_id: World.find(params[:from_world]).world_type.id,
               to_world_type_id: World.find(params[:to_world]).world_type.id).first
  rescue
    {}
  end
end
