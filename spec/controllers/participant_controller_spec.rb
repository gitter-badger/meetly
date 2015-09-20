require 'rails_helper'
require 'output_helper'

RSpec.describe ParticipantsController, type: :controller do
  before(:each) do
    OutputHelper.capture_stdout { load "#{Rails.root}/db/seeds.rb" }
  end

  it "responds with created and creates participant on valid participant request"

  it "responds with bad request when request parameters does not contain participant" do
    post :receive_form, format: :json,  participanto: { nombre: "juan" } 
    
    expect(response.status).to eq(404)
    expect(response.body).to eq('error: "No participant in request parameters."')
  end

  it "responds with not found when participant_form posted with event that does not exist" do 
    
  end

  it "responds with 601 when participant violates unique constraint"

end
