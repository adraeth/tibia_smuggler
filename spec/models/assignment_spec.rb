# == Schema Information
#
# Table name: assignments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  permission_id :integer
#

require 'spec_helper'

describe Assignment do

  let(:user) { FactoryGirl.create(:user) }
  let(:permission) { FactoryGirl.create(:permission) }

  before do
    user.permissions << permission
    @assignment = Assignment.first
  end

  subject { @assignment }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:user_id) }
    it { should respond_to(:permission_id) }
  end

  it { should be_valid }

end
