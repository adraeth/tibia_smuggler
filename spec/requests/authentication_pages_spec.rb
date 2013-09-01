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

  describe 'authorization' do
    let!(:rate) { FactoryGirl.create(:rate) }

    describe 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'in the Users controller' do
        describe 'visiting the show page' do
          before { visit user_path(user) }
          it { should have_title('Sign up / Login') }
        end
      end

      describe 'in the Orders controller' do
        let(:order) { FactoryGirl.create(:order) }

        describe 'visiting the show page' do
          before { visit order_path(order) }
          it { should have_title('Sign up / Login') }
        end

        describe 'visiting the index page' do
          before { visit orders_path }
          it { should have_title('Sign up / Login') }
        end
      end
    end

    describe 'for wrong user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      let(:order) { FactoryGirl.create(:order) }

      before { sign_in user }

      describe 'visiting Order#show page' do
        before { visit order_path(order) }
        it { should_not have_title('|') }
      end

      describe 'visiting User#show page' do
        before { visit user_path(wrong_user) }
        it { should_not have_title('|') }
      end
    end

    describe 'for signed-in users' do

    end
  end
end
