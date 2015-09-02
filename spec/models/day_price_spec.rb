require 'rails_helper'

RSpec.describe DayPrice, type: :model do
  describe 'ActiveModel validations' do
    it 'has valid factory' do
      FactoryGirl.create(:event)
      expect(FactoryGirl.build(:day_price)).to be_valid
    end

    it 'is invalid without price' do
      FactoryGirl.create(:event)
      expect(FactoryGirl.build(:day_price, price: nil)).not_to be_valid
    end

    it 'is invalid without pricing_period' do
      FactoryGirl.create(:event)
      expect(FactoryGirl.build(:day_price, pricing_period: nil)).not_to be_valid
    end

    it 'is invalid without role' do
      FactoryGirl.create(:event)
      expect(FactoryGirl.build(:day_price, role: nil)).not_to be_valid
    end
  end
end
