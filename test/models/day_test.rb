require 'test_helper'

class DayTest < ActiveSupport::TestCase

   should validate_presence_of(:number)
   should validate_uniqueness_of(:number)

end
