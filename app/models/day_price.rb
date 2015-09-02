class DayPrice < ActiveRecord::Base
  validates :price, :pricing_period_id, :day_id, :role_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :pricing_period
  belongs_to :role
  belongs_to :day
  end
