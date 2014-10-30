class Role < ActiveRecord::Base
	has_many :participants
	belongs_to :price_table

  validates :name, :uniqueness => true, :presence => true
end