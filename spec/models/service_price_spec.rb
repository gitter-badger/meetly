require 'rails_helper'

RSpec.describe ServicePrice, type: :model do
  describe "ActiveModel validations" do 
    it "has valid factory" do    	
      FactoryGirl.create(:event)
      FactoryGirl.create(:service_group)
  	  expect(FactoryGirl.create(:service_price)).to be_valid
    end
  end
end
