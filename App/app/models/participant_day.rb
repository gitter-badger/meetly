class ParticipantDay < ActiveRecord::Base
	belongs_to :participant
	belongs_to :day
end