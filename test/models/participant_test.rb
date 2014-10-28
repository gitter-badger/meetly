require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase


  should validate_presence_of(:name)
  should validate_presence_of(:surname)
  should validate_presence_of(:email)
  should validate_presence_of(:age)
  should validate_presence_of(:role)
  should validate_numericality_of(:age)
  should ensure_length_of(:days).is_at_least(1).is_at_most(3)
  should belong_to(:role)
  should have_many(:days)


  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @todd = FactoryGirl.create(:participant)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  test "participant should have proper cost calculation" do
    #TODO
  end

end