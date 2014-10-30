class PriceTable < ActiveRecord::Base
	has_many :roles

  validates_presence_of :name, :days, :day1, :day2, :day3, :night, :dinner
  validates_uniqueness_of :name
end