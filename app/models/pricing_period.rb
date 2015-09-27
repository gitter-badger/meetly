class PricingPeriod < ActiveRecord::Base
  belongs_to :event
  has_many :day_prices
  has_many :event_prices
  validates :name, :start_date, :end_date, :event_id, presence: true

  def self.current_period
    current_date = Time.now.to_date
    current_period = PricingPeriod.all.select { |pp| current_date < pp.end_date && current_date >= pp.start_date }
    current_period.first
  end
end
