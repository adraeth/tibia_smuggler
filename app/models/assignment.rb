# == Schema Information
#
# Table name: assignments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  permission_id :integer
#

class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :permission

  validates_uniqueness_of :permission_id, scope: :user_id  # TODO: tests...
end
