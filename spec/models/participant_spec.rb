require 'rails_helper'

describe Participant, type: :model do
  describe 'ActiveModel validations' do
    before(:each) do
      FactoryGirl.create(:event)
    end

    it 'has a valid factory' do
      expect(FactoryGirl.create(:participant)).to be_valid
    end

    it 'is invalid without first name' do
      expect(FactoryGirl.build(:participant, first_name: nil)).to_not be_valid
    end

    it 'is invalid without last name'

    it 'is invalid without a gender'

    it 'is invalid without an email'

    it 'is invalid without an age'

    it 'validates numericality of age'

    it 'is invalid without a city'

    it 'is invalid without phone'

    it 'is invalid without role'

    it 'is invalid without status'

    it 'is invalid without event'

    it 'calculates expected cost'

    it 'calculates expected deadline before end_date of pricing period'

    it 'calculates expected deadline after end_date of pricing period'
  end
end
