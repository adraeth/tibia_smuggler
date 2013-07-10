# == Schema Information
#
# Table name: order_statuses
#
#  id   :integer          not null, primary key
#  text :string(255)
#

class OrderStatus < ActiveRecord::Base
  has_many :orders

  attr_accessible :text

  validates :text, presence: true, uniqueness: true
end
