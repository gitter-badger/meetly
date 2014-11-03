require 'test_helper'

class DinnerTest < ActiveSupport::TestCase

  should validate_presence_of(:number)
  should validate_uniqueness_of(:number)

  def setup
    @dinner = FactoryGirl.build(:dinner)
  end

  test "should respond to participants" do
    assert_respond_to @dinner, :participants, "Dinner cannot have any participants!?"
  end
end
