require 'rails_helper'

describe Event do
  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:event, capacity: 100)).to be_valid
    end

    it 'is invalid without a name' do
      expect(FactoryGirl.build(:event, name: nil)).to_not be_valid
    end

    it 'is invalid without an owner' do
      expect(FactoryGirl.build(:event, owner_id: nil)).to_not be_valid
    end

    it 'is invalid without a start date' do
      expect(FactoryGirl.build(:event, start_date: nil)).to_not be_valid
    end

    it 'is invalid without end date' do
      expect(FactoryGirl.build(:event, end_date: nil)).to_not be_valid
    end

    it 'has registration status closed when capacity is exceeded' do
      event = FactoryGirl.build(:event, capacity: 0)
      expect(event.registration_status).to eq("closed")
    end

    it 'has registration status opened when capacity is not exceeded' do
      event = FactoryGirl.build(:event, capacity: 100)
      expect(event.registration_status).to eq("open")
    end
  end
end
