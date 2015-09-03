class ServicePrice < ActiveRecord::Base
  validates :price, :service_id, :role_id, presence: true
  validates :service_id, uniqueness: { scope: :role_id }
  belongs_to :service
  belongs_to :role
end
