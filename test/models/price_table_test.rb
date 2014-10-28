require 'test_helper'

class PriceTableTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:days)
  should validate_uniqueness_of(:name)
end