class PricingPeriod < ActiveRecord::Base
  belongs_to :event
  has_many :day_prices
  has_many :event_prices
  validates :name, :start_date, :end_date, :event_id, presence: true
end
