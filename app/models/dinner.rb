class Dinner < ActiveRecord::Base
  has_many :participant_dinners
  has_many :participants, through: :participant_dinners

  validates :number, presence: true, uniqueness: true
end
