class Event < ActiveRecord::Base
  validates :name, :start_date, :end_date, :owner_id, presence: true
  belongs_to :owner, class_name: 'User'
  has_many :days
  has_many :participants
  has_many :services
  has_many :event_prices
  has_many :pricing_periods

  before_create :generate_random_id

  def to_param
    unique_id
  end

  private

  def generate_random_id
  begin
    self.unique_id = SecureRandom.random_number(9999999)
  end while self.class.exists?(unique_id: unique_id.to_s)
  end
end
