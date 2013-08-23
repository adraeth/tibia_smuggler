require 'spec_helper'

describe 'AuthenticationPages' do

  subject { page }

  describe 'sign-up and login page' do
    before { visit login_path }

    it { should have_title('Sign up / Login') }
    it { should have_selector('h2', text: 'Log in...') }
    it { should have_selector('h2', text: '... or create a new account!') }
  end

  describe 'login' do
    before { visit login_path }

    describe 'with invalid information' do
      before { click_button 'Log in' }

      it { should have_title('Sign up / Login') }
      it { should have_selector('div#error_explanation') }
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        within 'form#login-form' do
          fill_in 'Email or nickname',    with: user.email.upcase
          fill_in 'Password', with: user.password
          click_button 'Log in'
        end
      end

      it { should have_title(user.name) }
      it { should have_link('Account', href: user_path(user)) }
      it { should_not have_link('Account', href: login_path) }
    end
  end
end
