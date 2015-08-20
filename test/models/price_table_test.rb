require 'test_helper'

class PriceTableTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:days)
  should validate_presence_of(:day1)
  should validate_presence_of(:day2)
  should validate_presence_of(:day3)
  should validate_presence_of(:night)
  should validate_presence_of(:dinner)
  should validate_uniqueness_of(:name)
  should have_many(:roles)
end
