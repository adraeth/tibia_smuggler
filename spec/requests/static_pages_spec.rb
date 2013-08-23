require 'spec_helper'

describe 'Static pages' do

  subject { page }

  let(:base_title) { 'Tibia Smuggler WT' }

  describe 'Help page' do

    before { visit help_path }
    it { should have_title("#{ base_title } | Help") }
  end

end