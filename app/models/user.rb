# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  signup_ip       :string(255)
#

class User < ActiveRecord::Base

  has_many :assignments, dependent: :destroy
  has_many :permissions, through: :assignments
  has_many :orders

  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

  before_create :protect_from_flooding

  after_create  :send_welcome_email

  before_save   { email.downcase! }
  before_save   :create_remember_token
  before_save   :provide_signup_ip_if_nil

  VALID_NAME_REGEX = /\A[a-z0-9 ]+\z/i
  validates :name,  format: { with: VALID_NAME_REGEX }, length: { minimum: 3, maximum: 20 } ,
            uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def save_signup_ip(ip)
    self.signup_ip ||= ip
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    # When User is created through console/test env
    def provide_signup_ip_if_nil
      self.signup_ip ||= 'Not provided'
    end

    def protect_from_flooding
      false unless User.where('created_at > ? AND signup_ip = ?', 1.day.ago, signup_ip).count < 2
    end

    def send_welcome_email
      UserMailer.signup_completed_email(self).deliver
    end

end
