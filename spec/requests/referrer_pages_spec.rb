require 'spec_helper'

def lowercased_dashed_version_of(username)
  username.downcase.gsub(' ', '_')
end

describe 'ReferrerPages' do

  before { @referrer = FactoryGirl.create(:user) }

  describe 'when referrer is found' do

    let(:path_to_existing_referrer) { "/referrer/#{lowercased_dashed_version_of(@referrer.name)}" }

    before { get path_to_existing_referrer }

    it 'should save referrer in the session' do
      expect(session[:referrer]).to equal(@referrer.id)
    end

    it 'should redirect to root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'should not set flash warning to be displayed' do
      flash[:no_referrer].should be_nil
    end
  end

  describe 'when referrer is not found' do

    let(:path_to_inexistent_referrer) { '/referrer/a9fBv#4!2' }

    before { get path_to_inexistent_referrer }

    it 'should not save referrer in the session' do
      expect(session[:referrer]).to be_nil
    end

    it 'should redirect to root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'should set flash warning to be displayed' do
      flash[:no_referrer].should eql('User specified as your referrer could not be found!')
    end
  end
end