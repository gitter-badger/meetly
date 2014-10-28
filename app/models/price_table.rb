class PriceTable < ActiveRecord::Base
	has_many :roles

  validates_presence_of :name, :days
  validates_uniqueness_of :name
end