class Service < ActiveRecord::Base
	validates :name, :price, :event_id, :service_group_id, presence: true
	validates :name, uniqueness: { scope: :event_id, message: "one specific service per event!" }
	validates :price, numericality: { greater_than_or_equal_to: 0 } 
	belongs_to :service_group
	belongs_to :event
	has_many :participant_services
	has_many :participants, through: :participant_services
end
