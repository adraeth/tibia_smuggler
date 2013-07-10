# == Schema Information
#
# Table name: permissions
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Permission < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :users, through: :assignments

  attr_accessible :name # TODO: Possible security vulnerability?

  VALID_NAME_REGEX = /\Acan(_[a-z]{2,}){1,}\z/
  validates :name,  format: { with: VALID_NAME_REGEX }, length: { minimum: 6, maximum: 30 } ,
            uniqueness: { case_sensitive: false } # TODO: Regex enforces lowercase already, needed?
end
