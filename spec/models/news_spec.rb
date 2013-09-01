# == Schema Information
#
# Table name: news
#
#  id           :integer          not null, primary key
#  date_to_show :datetime
#  title        :string(255)
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe News do

  before { @news = News.new(date_to_show: Time.now, title: 'Test News',
                             content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.') }

  subject { @news }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:date_to_show) }
    it { should respond_to(:title) }
    it { should respond_to(:content) }
  end

  it { should be_valid }

  describe 'when date_to_show is not present' do
    before { @news.date_to_show = '' }
    it { should_not be_valid }
  end

  describe 'when date_to_show is later than current date' do
    let!(:visible_news) do
      FactoryGirl.create(:news)
    end
    let!(:hidden_news) do
      FactoryGirl.create(:news, date_to_show: 1.day.from_now)
    end

    it 'the news should not be displayed' do
      News.visible.to_a.should == [visible_news]
    end
  end

  describe 'when latest is called in default scope' do
    let!(:first_news) do
      FactoryGirl.create(:news, date_to_show: 5.days.ago)
    end
    let!(:second_news) do
      FactoryGirl.create(:news, date_to_show: 6.days.ago)
    end
    let!(:third_news) do
      FactoryGirl.create(:news, date_to_show: 8.days.ago)
    end
    let!(:fourth_news) do
      FactoryGirl.create(:news, date_to_show: 1.day.ago)
    end

    it 'should return at most three news entries' do
      News.latest.count.should == 3
    end
    it 'should sort entries by date_to_show (default scope)' do
      News.latest.should == [fourth_news, first_news, second_news]
    end
  end

  describe 'when title is not present' do
    before { @news.title = '' }
    it { should_not be_valid }
  end

  describe 'when title is too short' do
    before { @news.title = 'a' * 4 }
    it { should_not be_valid }
  end

  describe 'when title is too long' do
    before { @news.title = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when content is not present' do
    before { @news.content = '' }
    it { should_not be_valid }
  end

  describe 'when content is too short' do
    before { @news.content = 'a' * 19 }
    it { should_not be_valid }
  end

  describe 'when content is too long' do
    before { @news.content = 'a' * 1001 }
    it { should_not be_valid }
  end
end
