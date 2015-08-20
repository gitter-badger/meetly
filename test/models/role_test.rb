require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
  should belong_to(:price_table)
  should have_many(:participants)
end
