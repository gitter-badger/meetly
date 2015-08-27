class Event < ActiveRecord::Base
  validates :name, :start_date, :end_date, :owner_id, presence: true
  belongs_to :owner, class_name: 'User'
  belongs_to :address
  has_many :days
  has_many :participants
  has_many :services

  accepts_nested_attributes_for :address
end
