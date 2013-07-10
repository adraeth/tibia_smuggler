# == Schema Information
#
# Table name: login_attempts
#
#  id         :integer          not null, primary key
#  ip         :string(255)
#  login      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe LoginAttempt do

  before { @login_attempt = FactoryGirl.build(:login_attempt) }

  subject { @login_attempt }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:ip) }
    it { should respond_to(:login) }
  end

  it { should be_valid }

  describe 'when ip is not present' do
    before { @login_attempt.ip = '' }
    it { should_not be_valid }
  end

  describe 'when login is not present' do
    before { @login_attempt.login = '' }
    it { should_not be_valid }
  end

  describe 'when valid' do
    it 'should allow a maximum of five failed logins' do
      10.times do
        login_attempt = @login_attempt.dup
        login_attempt.save if LoginAttempt.allowed?('127.0.0.1')
      end
      LoginAttempt.count.should eq(5)
    end
  end
end
