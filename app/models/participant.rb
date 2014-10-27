class Participant < ActiveRecord::Base
	belongs_to :role
	has_many :participant_days
	has_many :days, through: :participant_days

  validates_presence_of :name, :surname, :email, :age, :city, :phone

end