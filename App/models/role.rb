class Role < ActiveRecord::Base
	has_many :participants
	belongs_to :price_table
end