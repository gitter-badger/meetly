class PricingPeriod < ActiveRecord::Base
  belongs_to :event
  has_many :day_prices
  has_many :event_prices
  validates :name, :start_date, :end_date, :event_id, presence: true

  def self.current_period(event_id)
    current_date = Time.now.getlocal('+01:00').to_date
    current_period = PricingPeriod.all.select { |pp| current_date < pp.end_date && current_date >= pp.start_date && pp.event_id == event_id }
    current_period.first
  end

  def self.corresponding_period(date, event_id)
    corresponding_period = PricingPeriod.all.select { |pp| date < pp.end_date && date >= pp.start_date && pp.event_id == event_id }
    corresponding_period.first
  end    
end
