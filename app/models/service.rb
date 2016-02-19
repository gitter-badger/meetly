class Service < ActiveRecord::Base
  validates :name, :event_id, presence: true
  validates :name, uniqueness: { scope: :event_id, message: "one specific service per event!" }
  belongs_to :service_group
  belongs_to :event
  has_many :participant_services
  has_many :service_prices
  has_many :participants, through: :participant_services

  scope :in_service_group, -> (service_group) { where(service_group: ServiceGroup.find_by(name: service_group)) }
  scope :concerning_dinner, -> {where('name LIKE ?', "%Obiad%")}
end
