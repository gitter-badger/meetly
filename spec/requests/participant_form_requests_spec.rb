require 'rails_helper'
require 'output_helper'
require 'request_helper'

RSpec.describe "participant_form requests", type: :request do
  before(:each) do
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/01_jestwiecej_seed.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/02_add_guest_role.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/03_add_blaine_event.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/04_add_gary_event.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/05_add_agreement.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/06_move_created_to_registration.rb" }
  end

  it 'responds with form_data on get' do
    event = Event.find_by(name: 'Randy Clark 2-4.06')
    role_id = Role.find_by(name: 'Uczestnik', event_id: event.id).id
    id = event.unique_id
    get "/events/#{id}/participant_form",  format: :json

    expect(response).to be_success

    current_period = PricingPeriod.current_period event.id
    event_price = event.event_prices.select { |ep| ep.role_id == role_id && ep.pricing_period_id == current_period.id }.first

    json = JSON.parse(response.body)
    expect(json['event_price']).to eq(event_price.price.to_s)
    expect(json['services'].first['items'].length).to eq(2)
    expect(json['days'].length).to eq(2)

    day1_price = Day.find_by(event_id: event.id, number: 1).day_prices.select { |dp| dp.role_id == role_id && dp.pricing_period_id == current_period.id }.first
    day2_price = Day.find_by(event_id: event.id, number: 2).day_prices.select { |dp| dp.role_id == role_id && dp.pricing_period_id == current_period.id }.first

    expect(json['days'][0]['price']).to eq(day1_price.price.to_s)
    expect(json['days'][1]['price']).to eq(day2_price.price.to_s)
  end

  it 'responds with not found if event not found on get' do
    id = 454545
    get "events/#{id}/participant_form", format: :json
    expect(response).to have_http_status(:not_found)
  end

  it "responds with created and creates participant on valid participant request" do
    participant = {
      "first_name": "Chris",
      "last_name": "Pratt",
      "email": "CP@hollywood.pl",
      "age": 35,
      "city": "Wroclaw",
      "phone": "222222222",
      "gender": "man",
      "days": [{ "number": 1 }, { "number": 2 }],
      "services": [{ "name": "Noclegi" }]
    }
    id = Event.find_by(name: 'Randy Clark 2-4.06').unique_id

    params = { participant: participant }

    post "/events/#{id}/participant_form", params.to_json, 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json'

    expect(response.status).to eq(201)
    # TODO: check response body
  end


  it "responds with bad request when request parameters does not contain participant" do
    params = { participanto: { nombre: "juan" } }

    post "events/43434/participant_form", params.to_json, 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json'

    expect(response.status).to eq(400)
    expect(response.body).to eq('error: "No participant in request parameters."')
  end

  it "responds with not found when participant_form posted with event that does not exist" do
    params = { participant: RequestHelper.create_valid_participant("bart") }

    post "events/4334/participant_form", params.to_json, 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json'

    expect(response.status).to eq(404)
    expect(response.body).to eq('error: "Event provided in request not found."')
  end
end
