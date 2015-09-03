require 'rails_helper'

RSpec.describe PricingPeriod, type: :model do
  before(:each) do
    FactoryGirl.create(:event)
  end

  describe 'ActiveModel validations' do
    it 'has valid factory' do
      expect(FactoryGirl.create(:pricing_period)).to be_valid
    end

    it 'is not valid without start date' do
      expect(FactoryGirl.build(:pricing_period, start_date: nil)).to_not be_valid
    end

    it 'is not valid without end_date' do
      expect(FactoryGirl.build(:pricing_period, end_date: nil)).to_not be_valid
    end

    it 'is not valid without event' do
      expect(FactoryGirl.build(:pricing_period, event_id: nil)).to_not be_valid
    end

    it 'is not valid without name' do
      expect(FactoryGirl.build(:pricing_period, name: nil)).to_not be_valid
    end
  end
end
