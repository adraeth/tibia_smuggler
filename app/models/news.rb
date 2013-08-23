# == Schema Information
#
# Table name: news
#
#  id           :integer          not null, primary key
#  date_to_show :datetime
#  title        :string(255)
#  content      :text(1000)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class News < ActiveRecord::Base
  attr_accessible :content, :date_to_show, :title

  validates :date_to_show, presence: true
  validates :title, length: { in: 5..50 }
  validates :content, length: { in: 20..1000 }

  scope :visible, -> { where("date_to_show <= '#{ Time.now }'") }
  scope :latest,  -> { limit(3) }
  default_scope { order('date_to_show desc') }
end
