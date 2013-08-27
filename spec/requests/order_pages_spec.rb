require 'spec_helper'

describe 'Order pages' do

  subject { page }

  let(:base_title) { 'Tibia Smuggler WT' }
  let!(:first_world)  { FactoryGirl.create(:world, name: 'Aldora') }
  let!(:second_world) { FactoryGirl.create(:world, name: 'Celesta') }
  let!(:rate) { FactoryGirl.create(:rate) }

  describe 'new (root) page' do

    before { visit root_path }
    it { should have_title(base_title) }
    it { should_not have_selector('title', text: '|') }
    it { should have_link('Home Page', href: root_path) }
    it { should have_link('Order WT', href: '#') }
    it { should have_link('Gold List', href: gold_list_path) }
    it { should have_link('Help', href: help_path) }
    it { should have_selector('h2', text: 'Calculator')}
    it { should have_selector('h2', text: 'Short news')}

    describe 'when there are no news entries' do
      it { should have_selector('h3', text: 'There are no news entries yet!')}
    end

    describe 'when there are some news entries' do
      let!(:newsie) do
        FactoryGirl.create(:news)
      end
      before { visit current_path }
      it { should have_link('See all news entries', href: news_index_path)}
    end
  end

  describe 'order creation processing' do

    let(:submit) { 'Create my order' }

    describe 'for logged in user' do

      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit root_path
      end

      describe 'with invalid order information' do
        it 'should not create an order' do
          expect { click_button submit }.not_to change(Order, :count)
        end
        describe 'after submission' do
          before { click_button submit }

          it { should have_title(base_title) }
          it { should have_selector('div#error_explanation') }
        end
      end

      describe 'with valid order information' do

        before do
          within 'form#new_order' do
            fill_in 'order_amount_to',                              with: 50000
            fill_in 'character-from-input',                         with: 'Korni'
            fill_in 'character-to-input',                           with: 'foobar'
            select  'Aldora', from: 'order_world_from_id'
            select  'Celesta', from: 'order_world_to_id'
          end
        end

        it 'should create an order' do
          expect { click_button submit }.to change(Order, :count).by(1)
        end
      end
    end
    describe 'when user is not logged in' do

      before do
        visit root_path
        within 'form#new_order' do
          fill_in 'order_amount_to',                              with: 50000
          fill_in 'character-from-input',                         with: 'Korni'
          fill_in 'character-to-input',                           with: 'foobar'
          select  'Aldora', from: 'order_world_from_id'
          select  'Celesta', from: 'order_world_to_id'
        end
      end

      it 'should not create an order' do
        expect { click_button submit }.not_to change(Order, :count).by(1)
      end

      describe 'it should redirect to login page' do
        before { post orders_path }
        specify { response.should redirect_to(login_path) }
      end

      describe 'it should inform the user about what happened' do
        before { click_button submit }
        it { should have_selector('div.flash-info', text: 'You order details were saved. Please log in or create an account to confirm your order.') }
      end
    end
  end
end