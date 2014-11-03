class ParticipantNight < ActiveRecord::Base
  belongs_to :participant
  belongs_to :night
end