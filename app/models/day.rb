class Day < ActiveRecord::Base
  has_many :participant_days
  has_many :participants, through: :participant_days
  has_many :day_prices
  belongs_to :event
  validates :number, presence: true, uniqueness: { scope: :event_id }
  validates :event_id, presence: true
end
