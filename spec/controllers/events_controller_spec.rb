require 'rails_helper'
require 'output_helper'

RSpec.describe EventsController, type: :controller do
  before(:each) do
    OutputHelper.capture_stdout { load "#{Rails.root}/db/seeds.rb" }
  end

  it 'responds with form_data' do
    get :form_data, event: 'Poczatek', role: 'Uczestnik', format: :json 

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

  it 'responds with not found if event not found' do
    get :form_data, event: 'Pcztk', role: 'Uczestnik', format: :json
    expect(response).to have_http_status(:not_found)
  end

  it 'responds with not found if role not found' do
    get :form_data, event: 'Poczatek', role: 'Uczstk', format: :json
    expect(response).to have_http_status(:not_found)
  end
end
