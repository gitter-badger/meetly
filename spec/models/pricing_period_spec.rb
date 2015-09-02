require 'rails_helper'

RSpec.describe PricingPeriod, type: :model do
  before(:each) do
    FactoryGirl.create(:event)
  end

  describe 'ActiveModel validations' do
    it 'has valid factory' do
      expect(FactoryGirl.create(:pricing_period)).to be_valid
    end

    it 'is not valid without start date'

    it 'is not valid without end_date'

    it 'is not valid without event'

    it 'is not valid without name'
  end
end
