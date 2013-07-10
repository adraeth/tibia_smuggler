# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  order_status_id  :integer          not null
#  world_from_id    :integer          not null
#  world_to_id      :integer          not null
#  amount_from      :integer
#  amount_to        :integer
#  character_from   :string(255)
#  character_to     :string(255)
#  ip               :string(255)
#  rejection_reason :string(255)
#  accepted_at      :datetime
#  received_at      :datetime
#  completed_at     :datetime
#  rejected_at      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Order do

  before { @order = FactoryGirl.build(:order) }

  subject { @order }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:user) }
    it { should respond_to(:order_status) }
    it { should respond_to(:world_from) }
    it { should respond_to(:world_to) }
    it { should respond_to(:amount_from) }
    it { should respond_to(:amount_to) }
    it { should respond_to(:character_from) }
    it { should respond_to(:character_to) }
    it { should respond_to(:ip) }
    it { should respond_to(:rejection_reason) }
    it { should respond_to(:accepted_at) }
    it { should respond_to(:received_at) }
    it { should respond_to(:completed_at) }
    it { should respond_to(:rejected_at) }
  end

  it { should be_valid }

  describe 'when amount_to is not numeric' do
    before { @order.amount_to = '' }
    it { should_not be_valid }
  end

  describe 'when amount_to is lower than 10_000' do
    before { @order.amount_to = 9_999}
    it { should_not be_valid }
  end

  describe 'when amount_to is too high' do
    before { @order.amount_to = 5_000_001 }
    it { should_not be_valid }
  end

  describe 'when character names are too short' do
    before { @order.character_from = @order.character_to = 'aa' }
    it { should_not be_valid }
  end

  describe 'when character names are too long' do
    before { @order.character_from = @order.character_to = 'a' * 30 }
    it { should_not be_valid }
  end

  describe 'when character name format is invalid' do
    it 'should be invalid' do
      names = %w[ko$ni mati9]
      names.each do |invalid_name|
        @order.character_from = @order.character_to = invalid_name
        @order.should_not be_valid
      end
    end
  end

  describe 'when character name format is valid' do
    it 'should be valid' do
      names = %w[korni]
      names.each do |valid_name|
        @order.character_from = @order.character_to = valid_name
        @order.should be_valid
      end
    end
  end

  describe 'when world_from and world_to are the same' do
    before { @order.world_from = @order.world_to }
    it { should_not be_valid }
  end

  describe 'when rejection reason is too long' do
    before { @order.rejection_reason = 'a' * 51 }
    it { should_not be_valid }
  end
end
