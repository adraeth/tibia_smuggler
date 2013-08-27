require 'spec_helper'

describe UserMailer do

  before { @user = User.new(name: 'Example User', email: 'user@example.com',
                            password: 'foobar', password_confirmation: 'foobar') }

  describe 'when a new account is created' do

    before { @user.save }

    it 'an email notification should be sent' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
