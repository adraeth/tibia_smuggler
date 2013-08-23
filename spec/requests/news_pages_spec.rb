require 'spec_helper'

describe 'News pages' do

  subject { page }

  let(:base_title) { 'Tibia Smuggler WT' }
  let(:no_news_message) { 'There are no news entries yet!' }

  describe 'News index page' do
    before { visit gold_list_path }
    it { should have_title("#{ base_title} | Gold List") }
  end

  describe 'News archive page' do

    before { visit news_index_path }
    it { should have_title("#{ base_title} | News archive") }
    it { should have_selector('h2', text: 'News archive')}
    it { should have_selector('h2', text: 'Info')}

    describe 'when there are no news entries' do
      it { should have_selector('h3', text: no_news_message)}
    end

    describe 'should not show entries with date_to_show later than current time' do
      let!(:newsie) do
        FactoryGirl.create(:news, date_to_show: Time.now + 1.day)
      end
      before { visit current_path }
      it { should have_selector('h3', text: no_news_message)}
    end

    describe 'should not display error message when there are visible news entries' do
      let!(:newsie) do
        FactoryGirl.create(:news, date_to_show: Time.now)
      end
      before { visit current_path }
      it { should_not have_selector('h3', text: no_news_message) }
    end
  end

  describe 'news show page' do
    let(:news) { FactoryGirl.create(:news) }
    before { visit news_path(news) }

    it { should have_title("#{ base_title} | #{ news.title }") }
    it { should have_selector('div.news-content', text: news.content )}
    it { should have_link('Return to news archive', href: news_index_path )}

    describe 'when the news is not to be shown yet' do
      before do
        news.date_to_show = Time.now + 1.day
        news.save
        visit current_path
      end
      it 'should redirect back to news archive page' do
        current_path.should == news_index_path
      end
    end

    describe 'when the news does not exist' do
      before do
        news.destroy
        visit current_path
      end
      it 'should redirect back to news archive page' do
        current_path.should == news_index_path
      end
    end
  end
end