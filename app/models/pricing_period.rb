class PricingPeriod < ActiveRecord::Base
	belongs_to :event
	validates :name, :start_date, :end_date, :event_id, presence: true
end
