class ParticipantDinner < ActiveRecord::Base
  belongs_to :participant
  belongs_to :dinner
end