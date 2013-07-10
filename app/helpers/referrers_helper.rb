module ReferrersHelper

  def dash_to_space_in(dashed_referrer)
    dashed_referrer.gsub('_', ' ')
  end

  def referrer_as_user_for(dashed_referrer)
    Rails.env.production? ? query = 'name ILIKE ?' : query = 'name LIKE ?'
    User.where(query, dash_to_space_in(dashed_referrer)).first # Can be nil!
  end
end