require 'rails_helper'
require 'output_helper'
require 'request_helper'

RSpec.describe "participant_form requests", type: :request do
  before(:each) do
    OutputHelper.capture_stdout { load "#{Rails.root}/db/seeds.rb" }
  end

  it 'responds with form_data on get' do
    get '/participant_form', event: 'Poczatek', role: 'Uczestnik', format: :json 

    expect(response).to be_success
    json = JSON.parse(response.body)
    expect(json['event_price']).to eq('140.0')
    expect(json['services'].length).to eq(2)
    expect(json['days'].length).to eq(3)

    expect(json['days'][0]['price']).to eq('40.0')
    expect(json['days'][1]['price']).to eq('60.0')
    expect(json['days'][2]['price']).to eq('60.0')
    expect(json['services'][0]['price']).to eq('10.0')
    expect(json['services'][1]['price']).to eq('10.0')
  end

  it 'responds with not found if event not found on get' do
    get '/participant_form', event: 'Pcztk', role: 'Uczestnik', format: :json 
    expect(response).to have_http_status(:not_found)
  end

  it 'responds with not found if role not found on get' do
    get '/participant_form', event: 'Poczatek', role: 'Uczstk', format: :json 
    expect(response).to have_http_status(:not_found)
  end


  it "responds with created and creates participant on valid participant request"

  it "responds with bad request when request parameters does not contain participant" do
    params = { evento: "El Comenzado", participanto: { nombre: "juan" } }

    post "/participant_form", params.to_json, { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json'}
    
    expect(response.status).to eq(400)
    expect(response.body).to eq('error: "No participant in request parameters."')
  end

  it "responds with not found when participant_form posted with event that does not exist" do 
    params = { event: "Pcztk", participant: RequestHelper.create_valid_participant("bart") }

    post "/participant_form", params.to_json, { 'CONTENT_TYPE': 'application/json', 'ACCEPT': 'application/json'}

    expect(response.status).to eq(404)
    expect(response.body).to eq('error: "Event provided in request not found."')
  end

  it "responds with 601 when participant violates unique constraint"

end
