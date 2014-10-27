require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase


  should validate_presence_of(:name)
  should validate_presence_of(:surname)
  should validate_presence_of(:email)
  should validate_presence_of(:age)


  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @todd = FactoryGirl.build(:participant)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  test "receive_form creates new participant" do

  end

  test "receive_form calculates good price for whole conference" do

  end

  test "receive_form calculates good price for nights and dinners" do

  end

  test "participant should respond to role" do
    assert_respond_to @todd, :role
  end

  test "participant should respond to days" do
    assert_respond_to @todd, :days
  end
end