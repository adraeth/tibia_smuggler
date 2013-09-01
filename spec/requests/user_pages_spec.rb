require 'spec_helper'

describe 'User pages' do

  subject { page }

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit user_path(user)
    end

    it { should have_title(user.name) }
  end

  describe 'sign-up processing' do

    before { visit login_path }

    let(:submit) { 'Create my account' }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe 'after submission' do
        before { click_button submit }

        it { should have_title('Sign up / Login') }
        it { should have_selector('div#error_explanation') }
      end
    end

    describe 'with valid information' do
      before do
        within 'form#new_user' do
          fill_in 'Nickname',         with: 'Example User'
          fill_in 'Email',        with: 'user@example.com'
          fill_in 'Password',     with: 'foobar'
          fill_in 'Confirmation', with: 'foobar'
        end
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      it 'should allow a maximum of two new users per day with the same ip' do
        5.times do
          User.create(name: ('a'..'z').to_a.shuffle[0..7].join,
                      email: "#{ ('a'..'z').to_a.shuffle[0..4].join }@example.com",
                      password: 'foobar', password_confirmation: 'foobar')
        end
        User.count.should eq(2)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_title(user.name) }
        it { should_not have_link('Account', href: login_path) }
      end
    end
  end
end
