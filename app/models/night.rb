class Night < ActiveRecord::Base
  has_many :participant_nights
  has_many :participants, through: :participant_nigths

  validates :number, presence: true, uniqueness: true
end