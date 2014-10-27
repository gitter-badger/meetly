class Day < ActiveRecord::Base
	has_many :participant_days
	has_many :participants, through: :participant_days
end