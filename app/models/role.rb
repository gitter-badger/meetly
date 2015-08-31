class Role < ActiveRecord::Base
  has_many :participants
  has_many :day_prices
  has_many :event_prices
  has_many :service_prices
  belongs_to :price_table

  validates :name, uniqueness: true, presence: true
end
