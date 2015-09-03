require 'rails_helper'

RSpec.describe ServicePrice, type: :model do
  before(:each) do
    FactoryGirl.create(:event)
  end

  describe 'ActiveModel validations' do
    it 'has valid factory' do
      expect(FactoryGirl.create(:service_price)).to be_valid
    end

    it 'is not valid without price' do
      expect(FactoryGirl.build(:service_price, price: nil)).to_not be_valid
    end

    it 'is not valid without role' do
      expect(FactoryGirl.build(:service_price, role_id: nil)).to_not be_valid
    end

    it 'is not valid without service' do
      expect(FactoryGirl.build(:service_price, service_id: nil)).to_not be_valid
    end

    it 'validates uniqueness of role in scope of service' do
      FactoryGirl.create(:service_price, service_id: 1, role_id: 1)

      expect(FactoryGirl.build(:service_price, service_id: 1, role_id: 1)).to_not be_valid
    end
  end
end
