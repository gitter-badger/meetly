require 'rails_helper'

RSpec.describe EventPrice, type: :model do
  describe "ActiveModel validations" do 
  	it "has valid factory" do 
  		FactoryGirl.create(:event)
  		expect(FactoryGirl.create(:event_price)).to be_valid
  	end
  end
end
