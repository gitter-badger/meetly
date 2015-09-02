require 'rails_helper'

RSpec.describe DayPrice, type: :model do
  describe "ActiveModel validations" do
    it "has valid factory" do
      FactoryGirl.create(:event)
      expect(FactoryGirl.create(:day_price)).to be_valid
    end
  end
end
