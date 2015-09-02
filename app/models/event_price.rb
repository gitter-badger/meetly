class EventPrice < ActiveRecord::Base
  validates :price, :event_id, :pricing_period_id, :role_id, presence: true
  belongs_to :event
  belongs_to :role
  belongs_to :pricing_period
end
