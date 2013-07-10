# == Schema Information
#
# Table name: rates
#
#  id                 :integer          not null, primary key
#  from_world_type_id :integer
#  to_world_type_id   :integer
#  rate               :decimal(, )
#  reducible          :boolean          default(FALSE), not null
#  reduction_step     :decimal(, )      default(0.0), not null
#

class Rate < ActiveRecord::Base
  belongs_to :from_world_type, class_name: 'WorldType', foreign_key: 'from_world_type_id'
  belongs_to :to_world_type, class_name: 'WorldType', foreign_key: 'to_world_type_id'

  attr_accessible :from_world_type, :to_world_type, :rate, :reducible, :reduction_step

  validates :rate, numericality: true
  validates :reducible, inclusion: [true, false]
  validates :reduction_step, numericality: true
end
