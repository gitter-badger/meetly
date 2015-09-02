require 'rails_helper'

RSpec.describe PricingPeriod, type: :model do
  describe "ActiveModel validations" do
    it "has valid factory" do
      FactoryGirl.create(:event)
      expect(FactoryGirl.create(:pricing_period)).to be_valid
    end
  end
end
