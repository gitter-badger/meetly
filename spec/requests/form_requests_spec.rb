require 'rails_helper'
require 'output_helper'
require 'request_helper'

RSpec.describe "Registration form", type: :request do
  before(:each) do
    OutputHelper.capture_stdout { load "#{Rails.root}/db/seeds.rb" }
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
