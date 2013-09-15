class LogEntry < ActiveRecord::Base

  attr_accessible :message

  validates :message, length: { minimum: 5, maximum: 255 }

  default_scope { order('created_at desc') }
  scope :newest, -> { limit(100) }
end
