require 'spec_helper'

describe OrderMailer do

  before do
    @user = FactoryGirl.create(:user)
    @order = @user.orders.build(world_from_id: 15, world_to_id: 60, amount_to: 20000, character_from: 'Korni', character_to: 'Mystie')
  end

  describe 'when an order is created' do

    before { @order.save }

    it 'an email notification should be sent' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end