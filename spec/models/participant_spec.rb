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

    it 'is invalid without last name' do
      expect(FactoryGirl.build(:participant, last_name: nil)).to_not be_valid
    end

    it 'is invalid without a gender' do
      expect(FactoryGirl.build(:participant, gender: nil)).to_not be_valid
    end

    it 'is invalid without an email' do
      expect(FactoryGirl.build(:participant, email: nil)).to_not be_valid
    end

    it 'is invalid without an age' do
      expect(FactoryGirl.build(:participant, age: nil)).to_not be_valid
    end

    it 'validates numericality of age' do
      expect(FactoryGirl.build(:participant, age: 'I am 23')).to_not be_valid
      expect(FactoryGirl.build(:participant, age: 'age')).to_not be_valid
    end

    it 'is invalid without a city' do
      expect(FactoryGirl.build(:participant, city: nil)).to_not be_valid
    end

    it 'is invalid without phone' do
      expect(FactoryGirl.build(:participant, phone: nil)).to_not be_valid
    end

    it 'is invalid without role' do
      expect(FactoryGirl.build(:participant, role_id: nil)).to_not be_valid
    end

    it 'is invalid without status' do
      expect(FactoryGirl.build(:participant, status: nil)).to_not be_valid
    end

    it 'is invalid without event' do
      expect(FactoryGirl.build(:participant, event_id: nil)).to_not be_valid
    end

    it 'calculates expected cost'

    it 'calculates expected deadline before end_date of pricing period'

    it 'calculates expected deadline after end_date of pricing period'
  end
end
