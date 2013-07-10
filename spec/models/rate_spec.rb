# == Schema Information
#
# Table name: rates
#
#  id                 :integer          not null, primary key
#  from_world_type_id :integer
#  to_world_type_id   :integer
#  rate               :decimal(, )
#  reducible          :boolean          default(FALSE), not null
#  reduction_step     :decimal(, )      default(0.0), not null
#

require 'spec_helper'

describe Rate do

  before do
    @rate = FactoryGirl.build(:rate)
  end

  subject { @rate }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:from_world_type) }
    it { should respond_to(:to_world_type) }
    it { should respond_to(:rate) }
    it { should respond_to(:reducible) }
    it { should respond_to(:reduction_step) }
  end

  it { should be_valid }

  describe 'when rate is not present/not numeric' do
    before { @rate.rate = '' }
    it { should_not be_valid }
  end

  describe 'when reducible is not present/not boolean' do
    before { @rate.reducible = '' }
    it { should_not be_valid }
  end

  describe 'when reduction_step is not present/not numeric' do
    before { @rate.reduction_step = '' }
    it { should_not be_valid }
  end
end
