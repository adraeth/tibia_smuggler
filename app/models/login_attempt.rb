# == Schema Information
#
# Table name: login_attempts
#
#  id         :integer          not null, primary key
#  ip         :string(255)
#  login      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LoginAttempt < ActiveRecord::Base
  attr_accessible :ip, :login

  validates :ip, presence: true
  validates :login, presence: true

  def self.allowed?(ip)
    LoginAttempt.where('ip = ? AND created_at > ?', ip, 5.minutes.ago).count > 4 ? false : true
  end
end
