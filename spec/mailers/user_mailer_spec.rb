require 'spec_helper'

describe UserMailer do

  before { @user = User.new(name: 'Example User', email: 'user@example.com',
                            password: 'foobar', password_confirmation: 'foobar') }

  let(:email) { UserMailer.signup_completed_email(@user) }

  describe 'when new account is created' do
    before { @user.save }

    describe 'list of delivered emails' do
      subject { ActionMailer::Base.deliveries }
      it { should_not be_empty }
    end
  end
end
