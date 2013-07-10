# == Schema Information
#
# Table name: order_statuses
#
#  id   :integer          not null, primary key
#  text :string(255)
#

require 'spec_helper'

describe OrderStatus do

  before { @order_status = OrderStatus.new(text: 'Test in progress') }

  subject { @order_status }

  describe 'should respond to its attributes and methods' do
    it { should respond_to(:text) }
    it { should respond_to(:orders) }
  end

  it { should be_valid }

  describe 'when status with the text is already in the database' do
    before do
      order_status_with_same_name = @order_status.dup
      order_status_with_same_name.text = @order_status.text
      order_status_with_same_name.save
    end

    it { should_not be_valid }
  end
end
