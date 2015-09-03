require 'rails_helper'

RSpec.describe Service, type: :model do
  before(:each) do
    FactoryGirl.create(:event)
    FactoryGirl.create(:service_group)
  end

  describe 'ActiveModel validations' do
    it 'has valid factory for a sequence of services' do
      expect(FactoryGirl.create(:service)).to be_valid
      expect(FactoryGirl.create(:service)).to be_valid
    end

    it 'is not valid without name' do
      expect(FactoryGirl.build(:service, name: nil)).to_not be_valid
    end

    it 'is not valid without event' do
      expect(FactoryGirl.build(:service, event_id: nil)).to_not be_valid
    end

    it 'is valid when limit is nil' do
      expect(FactoryGirl.build(:service, limit: nil)).to be_valid
    end

    it 'is valid without service_group' do
      expect(FactoryGirl.build(:service, service_group_id: nil)).to be_valid
    end
  end
end
