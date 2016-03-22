require 'rails_helper'

describe Day do
  describe 'Day' do
    it 'has a valid factory' do
      FactoryGirl.create(:event)
      expect(FactoryGirl.create(:day)).to be_valid
    end

    it 'is not valid without number' do
      FactoryGirl.create(:event)
      expect(FactoryGirl.build(:day, number: nil)).not_to be_valid
    end

    it 'is not valid without event' do
      expect(FactoryGirl.build(:day)).not_to be_valid
    end
  end
end
