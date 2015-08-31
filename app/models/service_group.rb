class ServiceGroup < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true
	has_many :services
end