# == Schema Information
#
# Table name: worlds
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  location             :string(255)
#  account              :integer
#  blocked_for_incoming :boolean
#  blocked_for_outgoing :boolean
#  amount               :integer
#  rate                 :decimal(, )
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  world_type_id        :integer
#

require 'spec_helper'

describe World do

  before { @world = FactoryGirl.build(:world) }

  subject { @world }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:name) }
    it { should respond_to(:location) }
    it { should respond_to(:account) }
    it { should respond_to(:blocked_for_incoming) }
    it { should respond_to(:blocked_for_outgoing) }
    it { should respond_to(:amount) }
    it { should respond_to(:rate) }
    it { should respond_to(:world_type) }
  end

  it { should be_valid }

  describe 'when all requested' do
    let!(:first_world) do
      FactoryGirl.create(:world, name: 'Hellesta')
    end
    let!(:second_world) do
      FactoryGirl.create(:world, name: 'Zanera')
    end
    let!(:third_world) do # Ehh, third world problems ; )
      FactoryGirl.create(:world, name: 'Aurora')
    end
    it 'should sort entries by name (default scope)' do
      World.all.should == [third_world, first_world, second_world]
    end
  end

  describe 'when name is not present' do
    before { @world.name = '' }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @world.name = 'a' * 31 }
    it { should_not be_valid }
  end

  describe 'when name is already taken' do
    before do
      world_with_same_name = @world.dup
      world_with_same_name.name = @world.name
      world_with_same_name.save
    end

    it { should_not be_valid }
  end

  describe 'when location is neither EU nor US' do
    before { @world.location = ''}
    it { should_not be_valid }
  end

  describe 'when account is not numeric' do
    before { @world.account = '' }
    it { should_not be_valid }
  end

  describe 'when account is equal or less than 0' do
    before { @world.account = 0 }
    it { should_not be_valid }
  end

  describe 'when account is higher than 5' do
    before { @world.account = 6 }
    it { should_not be_valid }
  end

  describe 'when blocked_for_incoming is neither true nor false' do
    before { @world.blocked_for_incoming = '' }
    it { should_not be_valid }
  end

  describe 'when blocked_for_outgoing is neither true nor false' do
    before { @world.blocked_for_outgoing = '' }
    it { should_not be_valid }
  end

  describe 'when amount is not numeric' do
    before { @world.amount = '' }
    it { should_not be_valid }
  end

  describe 'when rate is not present/not numeric' do
    before { @world.rate = '' }
    it { should_not be_valid }
  end
end
