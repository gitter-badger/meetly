require 'test_helper'

class NightTest < ActiveSupport::TestCase

  should validate_presence_of(:number)
  should validate_uniqueness_of(:number)

  def setup
    @night = FactoryGirl.build(:night)
  end

  test "should respond to participants" do
    assert_respond_to @night, :participants, "Night cannot have any participants!?"
  end
end
