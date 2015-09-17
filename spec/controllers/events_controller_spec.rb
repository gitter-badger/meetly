require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  it 'responds with form_data' do
    load "#{Rails.root}/db/seeds.rb"
    params = { event: 'Poczatek', role: 'Uczestnik' }
    get :form_data, event: 'Poczatek', role: 'Uczestnik', format: :json 
     #, params.to_json #?event=Poczatek&role=Uczestnik'

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
end
