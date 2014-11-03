require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase


  should validate_presence_of(:name)
  should validate_presence_of(:surname)
  should validate_presence_of(:email)
  should validate_presence_of(:age)
  should validate_presence_of(:role)
  should validate_presence_of(:gender)
  should validate_numericality_of(:age)
  should belong_to(:role)
  should have_many(:days)


  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    super
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  test "participant should have proper cost calculation" do
    p = Participant.last

    assert_equal p.cost, p.role.price_table.days + p.role.price_table.night
    assert_equal p.paid, 0
  end

  test "participant cant be created with more than 3 days" do
    p = Participant.first
    p.days.push(FactoryGirl.build(:day, number: 5))

    assert !p.valid?
  end

  test "participant has unique email, name, surname" do
    p1 = FactoryGirl.build(:participant)
    example = Participant.first
    p1.name = example.name
    p1.surname = example.surname
    p1.email = example.email
    assert !p1.valid?
  end
end