require 'test_helper'

class ParticipantsTest < ActionDispatch::IntegrationTest

  setup { host! 'api.blu-soft.pl' }

  test "root should lead to participant list" do
    visit root_url

    assert_equal root_path, current_path
    within("h1") do
      assert has_content? "Lista uczestników"
    end
  end

  test "receive_form with correct parameters should create new participant" do

    Participant.any_instance.stubs(:send_confirmation)

    participants_before = Participant.all.length
    get '/receive_form?name=todd&surname=white&age=55&nights=0&dinners=2&day1=true&day2=true&day3=true&gender=true&phone=767&email=x%40d.pl&city=ny'
    participants_after = Participant.all.length

    assert_equal 201, response.status
    assert_not_equal participants_before, participants_after
  end

  test "receive_form with incorrect parameters should return error" do
    Participant.any_instance.stubs(:send_confirmation)

    get '/receive_form?name=todd'

    errors = JSON.parse(response.body, symbolize_names: true)

    assert_equal 422, response.status
    assert_match /can't be blank/, errors[:surname].join
    assert_match /participant should attend at least one days/, errors[:days].join
  end


end