require 'rails_helper'

describe Participant, type: :model do
  describe 'ActiveModel validations' do
    it 'has a valid factory' do
	  FactoryGirl.create(:event)
      expect(FactoryGirl.create(:participant)).to be_valid
    end

    it 'is invalid without a first name' do
	  FactoryGirl.create(:event)
      expect(FactoryGirl.build(:participant, first_name: nil)).to_not be_valid
    end
  end
end
