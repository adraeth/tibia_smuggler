# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  order_status_id  :integer          not null
#  world_from_id    :integer          not null
#  world_to_id      :integer          not null
#  amount_from      :integer
#  amount_to        :integer
#  character_from   :string(255)
#  character_to     :string(255)
#  ip               :string(255)
#  rejection_reason :string(255)
#  accepted_at      :datetime
#  received_at      :datetime
#  completed_at     :datetime
#  rejected_at      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :order_status
  belongs_to :world_from, class_name: 'World'
  belongs_to :world_to, class_name: 'World'

  attr_accessible :amount_to, :character_from, :character_to, :world_from_id, :world_to_id # TODO: Fragile parameters exposed!

  before_create :calculate_amount_from
  before_create :check_world_locks
  before_create :lock_amount_to
  before_create :apply_status

  after_create :send_creation_email

  validates :amount_from, numericality: { greater_than_or_equal_to: 0 }, on: :update
  validates :amount_to, numericality: { greater_than_or_equal_to: 10_000, less_than_or_equal_to: 5_000_000 }
  VALID_CHARNAME_REGEX = /\A[a-z]+[a-z'\- ]+[a-z]\z/i
  validates :character_from, format: { with: VALID_CHARNAME_REGEX }, length: { maximum: 29 }
  validates :character_to, format: { with: VALID_CHARNAME_REGEX }, length: { maximum: 29 }
  validates :rejection_reason, length: { maximum: 50 }
  validates :user, presence: true
  validates :world_from, presence: true
  validates :world_to, presence: true
  validate  :world_from_and_to_must_differ

  scope :recent, -> { where("created_at >= '#{ 10.days.ago }'") }
  default_scope { order('created_at desc') }

  def calculate_amount_from
    return false unless world_from.present? and world_to.present? and amount_to.present?
    applied_rate = Rate.where(from_world_type_id: world_from.world_type, to_world_type_id: world_to.world_type).first
    rate_value = applied_rate.rate - applied_rate.reduction_step * rate_reduction_multiplier
    self.amount_from = amount_to * (1 + rate_value + world_to.rate - world_from.rate) # TODO: Think how it influences negative base_rate
    self.amount_from = amount_from.round(-2)
  end

  def check_world_locks
    return false if world_from.blocked_for_outgoing || world_to.blocked_for_incoming
    true
  end

  def accept
    ActiveRecord::Base.transaction do
      self.reload
      return false if order_status_id != 1
      self.order_status_id = 2
      self.accepted_at = Time.now
      self.save
    end
    send_acceptation_email
  end

  def confirm_parcel
    ActiveRecord::Base.transaction do
      self.reload
      return false if order_status_id != 2
      self.order_status_id = 3
      self.received_at = Time.now
      self.save
    end
    send_parcel_confirmation_email
  end

  def complete
    ActiveRecord::Base.transaction do
      self.reload
      return false if order_status_id != 3
      self.order_status_id = 4
      self.completed_at = Time.now
      add_amount_from
      self.save
    end
    send_completion_email
  end

  def destroy(message = 'cancelled by user')
    ActiveRecord::Base.transaction do
      self.reload
      return false unless (1..4).cover? order_status_id
      self.order_status_id = 5
      self.rejected_at = Time.now
      self.rejection_reason = message
      unlock_amount_to
      self.save
    end
    send_rejection_email
  end

  private

    def lock_amount_to
      world_to.amount -= amount_to
      world_to.save
    end

    def unlock_amount_to
      world_to.amount += amount_to
      world_to.save
    end

    def add_amount_from
      world_from.amount += amount_from
      world_from.save
    end

    def rate_reduction_multiplier
      return 0 unless amount_to.present?
      return 3 if amount_to >= 1_000_000
      return 2 if amount_to >= 600_000
      return 1 if amount_to >= 300_000
      0
    end

    def apply_status
      self.order_status_id = 1 # TODO: It should vary depending on User credibility, amounts, etc.
    end

    def world_from_and_to_must_differ
      errors.add(:world_to, 'and your world must be different') if world_from_id == world_to_id
    end

    def send_creation_email
      OrderMailer.order_created_email(self).deliver
    end

    def send_acceptation_email
      OrderMailer.order_accepted_email(self).deliver
    end

    def send_parcel_confirmation_email
      OrderMailer.parcel_confirmed_email(self).deliver
    end

    def send_completion_email
      OrderMailer.order_completed_email(self).deliver
    end

    def send_rejection_email
      OrderMailer.order_rejected_email(self).deliver
    end
end
