require 'rails_helper'

RSpec.describe PricingPeriod, type: :model do
	describe "ActiveModel validations" do 
		it "has valid factory" do
			FactoryGirl.create(:event)
			FactoryGirl.create(:pricing_period)
		end
	end
end
