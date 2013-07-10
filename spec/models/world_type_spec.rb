# == Schema Information
#
# Table name: world_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require 'spec_helper'

describe WorldType do

  before { @world_type = WorldType.new(name: 'Testify-PvP') }

  subject { @world_type }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:name) }
    it { should respond_to(:worlds) }
  end

  it { should be_valid }

  describe 'when name is too short' do
    before { @world_type.name = 'a' * 3 }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @world_type.name = 'a' * 21 }
    it { should_not be_valid }
  end

  describe 'when name format is invalid' do
    it 'should be invalid' do
      names = %w[open-PvP Optional-P5P]
      names.each do |invalid_name|
        @world_type.name = invalid_name
        @world_type.should_not be_valid
      end
    end
  end

  describe 'when name format is valid' do
    it 'should be valid' do
      names = %w[Preview Open-PvP]
      names.each do |valid_name|
        @world_type.name = valid_name
        @world_type.should be_valid
      end
    end
  end

  describe 'when name is already taken' do
    before do
      world_type_with_same_name = @world_type.dup
      world_type_with_same_name.name = @world_type.name
      world_type_with_same_name.save
    end

    it { should_not be_valid }
  end
end
