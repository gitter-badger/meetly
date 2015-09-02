class Role < ActiveRecord::Base
  has_many :participants
  has_many :day_prices
  has_many :event_prices
  has_many :service_prices

  validates :name, presence: true, uniqueness: { scope: :event_id }
end
