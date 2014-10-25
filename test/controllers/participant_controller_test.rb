require 'test_helper'

class ParticipantControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get receive_form" do
    get :receive_form
    assert_response :success
  end

end
