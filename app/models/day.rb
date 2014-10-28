class Day < ActiveRecord::Base
	has_many :participant_days
	has_many :participants, through: :participant_days

  validates_presence_of :number
  validates_uniqueness_of :number
end
