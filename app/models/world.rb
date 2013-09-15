# == Schema Information
#
# Table name: worlds
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  location             :string(255)
#  account              :integer
#  blocked_for_incoming :boolean
#  blocked_for_outgoing :boolean
#  amount               :integer
#  rate                 :decimal(, )
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  world_type_id        :integer
#

class World < ActiveRecord::Base
  belongs_to :world_type

  attr_accessible :account, :amount, :blocked_for_incoming, :blocked_for_outgoing, :location, :name, :rate, :world_type

  validates :account, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :blocked_for_incoming, inclusion: [true, false]
  validates :blocked_for_outgoing, inclusion: [true, false]
  validates :location, inclusion: %w[EU US]
  validates :name, uniqueness: true, length: 1..30
  validates :rate, numericality: true

  default_scope { order('name asc') }

  def toggle_outgoing_lock
    self.blocked_for_outgoing = !blocked_for_outgoing
    LogEntry.create(message: "Toggled outgoing lock for #{name}, current value: #{blocked_for_outgoing}")
    self.save
  end

  def toggle_incoming_lock
    self.blocked_for_incoming = !blocked_for_incoming
    LogEntry.create(message: "Toggled incoming lock for #{name}, current value: #{blocked_for_outgoing}")
    self.save
  end

  def change_amount(amount)
    self.amount += amount
    if amount >= 0
      LogEntry.create(message: "Added #{amount} to #{name}, currently in stock: #{self.amount}.")
    elsif self.amount < 0
      LogEntry.create(message: "Attempted subtracting #{amount.abs} from #{name}, but there was not enough gold to subtract from.")
    else
      LogEntry.create(message: "Subtracted #{amount.abs} from #{name}, currently in stock: #{self.amount}.")
    end
    self.save
  end
end
