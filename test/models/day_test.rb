require 'test_helper'

class DayTest < ActiveSupport::TestCase
  should validate_presence_of(:number)
  should validate_uniqueness_of(:number)

  def setup
    @day = FactoryGirl.build(:day)
  end

  test 'should respond to participants' do
    assert_respond_to @day, :participants, 'Day cannot have any participants!?'
  end
end
