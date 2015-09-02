class Service < ActiveRecord::Base
  validates :name, :event_id, presence: true
  validates :name, uniqueness: { scope: :event_id, message: "one specific service per event!" }
  belongs_to :service_group
  belongs_to :event
  has_many :participant_services
  has_many :service_prices
  has_many :participants, through: :participant_services
end
