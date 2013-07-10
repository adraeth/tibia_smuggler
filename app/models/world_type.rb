# == Schema Information
#
# Table name: world_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class WorldType < ActiveRecord::Base
  has_many :worlds

  attr_accessible :name

  VALID_NAME_REGEX = /\A[A-Z]{1}[a-z]+(-[a-zA-Z]{3,})?\z/
  validates :name,  format: { with: VALID_NAME_REGEX }, length: { minimum: 4, maximum: 20 } ,
            uniqueness: { case_sensitive: false } # TODO: Regex enforces lowercase already, needed?
end
