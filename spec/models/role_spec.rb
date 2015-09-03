require 'rails_helper'

describe Role do
  before(:each) do
    FactoryGirl.create(:event)
  end

  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:role)).to be_valid
    end

    it 'is not valid without event' do
      expect(FactoryGirl.build(:role, event_id: nil)).to_not be_valid
    end

    it 'is not valid without name' do
      expect(FactoryGirl.build(:role, name: nil)).to_not be_valid
    end

    it 'validates uniqueness of name for event' do
      FactoryGirl.create(:role, name: 'identical', event_id: '1')
      expect(FactoryGirl.build(:role, name: 'identical', event_id: '1')).to_not be_valid
    end
  end
end
