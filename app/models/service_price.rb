class ServicePrice < ActiveRecord::Base
	validates :price, :service_id, :pricing_period_id, :role_id, presence: true
	belongs_to :service
	belongs_to :role
end
