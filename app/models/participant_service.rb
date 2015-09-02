class ParticipantService < ActiveRecord::Base
  belongs_to :participant
  belongs_to :service
end
