require 'rails_helper'

RSpec.describe EventPrice, type: :model do
  before(:each) do
    FactoryGirl.create(:event)
  end

  describe 'ActiveModel validations' do
    it 'has valid factory' do
      expect(FactoryGirl.create(:event_price)).to be_valid
    end

    it 'is not valid without price' do
      expect(FactoryGirl.build(:event_price, price: nil)).not_to be_valid
    end

    it 'is not valid without pricing_period' do
      expect(FactoryGirl.build(:event_price, pricing_period: nil)).not_to be_valid
    end

    it 'is not valid without event' do
      expect(FactoryGirl.build(:event_price, event: nil)).not_to be_valid
    end

    it 'is not valid withour role' do
      expect(FactoryGirl.build(:event_price, role: nil)).not_to be_valid
    end
  end
end
