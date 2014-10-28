require 'test_helper'

class ParticipantsTest < ActionDispatch::IntegrationTest


  setup { host! 'api.blu-soft.pl' }

  test "root should lead to participant list" do
    visit root_url

    assert_equal participants_path, current_path
    within("h1") do
      assert has_content? "Lista uczestników"
    end
  end

  test "receive_form with correct parameters should create new participant" do

    participants_before = Participant.all.length

    get '/receive_form?name=todd&surname=white&age=55&nights=0&dinners=2&day1=true&day2=true&day3=true&gender=true&phone=767&email=x%40d.pl&city=ny'

    assert_equal 200, response.status

    participants_after = Participant.all.length

    assert_not_equal participants_before, participants_after
  end

end