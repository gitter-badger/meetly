require 'test_helper'

class RolesTest < ActionDispatch::IntegrationTest

  test "get_role_price_table should return proper hash" do

    get '/get_role_price_table.json?name=Uczestnik'

    cost = JSON.parse(response.body, symbolize_names: true)

    price_table = PriceTable.find_by(name: 'Podstawowa')

    assert_equal 200, response.status
    assert_equal cost[:name], price_table.name
    assert_not_nil cost[:days]
    assert_not_nil cost[:day1]
    assert_not_nil cost[:day2]
    assert_not_nil cost[:day3]
    assert_not_nil cost[:dinner]
    assert_not_nil cost[:night]
  end

  test "get_role_price_table should not return with bad role name" do

    get '/get_role_price_table.json?name=Pastor'

    assert_equal 422, response.status
    assert_equal response.body, "null"
  end
end