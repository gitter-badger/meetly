require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase

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

  test "participant invalid without a name and email" do
    @todd.name = nil
    @todd.email = nil
    assert_presence(@todd, :name)
    assert_presence(@todd, :email)
  end

  test "participant should respond to role" do
    assert_respond_to @todd, :role
  end

  test "participant should respond to days" do
    assert_respond_to @todd, :days
  end
end