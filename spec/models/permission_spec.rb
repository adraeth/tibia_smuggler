# == Schema Information
#
# Table name: permissions
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require 'spec_helper'

describe Permission do

  before { @permission = Permission.new(name: 'can_test_permissions') }

  subject { @permission }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:name) }
    it { should respond_to(:users) }
    it { should respond_to(:assignments) }
  end

  it { should be_valid }

  describe 'when name is too short' do
    before { @permission.name = 'a' * 5 }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @permission.name = 'a' * 31 }
    it { should_not be_valid }
  end

  describe 'when name format is invalid' do
    it 'should be invalid' do
      names = %w[validate_things can_ check_marks_can Can_change can_chAnge]
      names.each do |invalid_name|
        @permission.name = invalid_name
        @permission.should_not be_valid
      end
    end
  end

  describe 'when name format is valid' do
    it 'should be valid' do
      names = %w[can_validate_orders can_work]
      names.each do |valid_name|
        @permission.name = valid_name
        @permission.should be_valid
      end
    end
  end

  describe 'when name is already taken' do
    before do
      permission_with_same_name = @permission.dup
      permission_with_same_name.name = @permission.name
      permission_with_same_name.save
    end

    it { should_not be_valid }
  end
end
