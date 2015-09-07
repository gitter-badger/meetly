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

    it 'is invalid with no days' do
      expect(FactoryGirl.build(:participant, days: [])).to_not be_valid
    end

    it 'calculates expected cost for whole event' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90

      services = FactoryHelper.create_services_with_group 'dinners', 2, 10, db[:role]

      d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]
      d2 = FactoryHelper.create_day_with_price 2, 60, db[:pricing_period], db[:role]

      p = FactoryGirl.create(:participant, days: [d1[:day], d2[:day]], services: [services[0][:service], services[1][:service]])

      expected_cost = db[:event_price].price + services[0][:service_price].price + services[1][:service_price].price

      expect(p.cost).to be(expected_cost)
    end

    it 'calculates expected cost for single days' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90

      services = FactoryHelper.create_services_with_group 'dinners', 2, 10, db[:role]

      d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]
      d2 = FactoryHelper.create_day_with_price 2, 60, db[:pricing_period], db[:role]
      d3 = FactoryHelper.create_day_with_price 3, 60, db[:pricing_period], db[:role]

      p = FactoryGirl.create(:participant, days: [d1[:day], d2[:day]], services: [services[0][:service], services[1][:service]])

      expected_cost = d1[:day_price].price + d2[:day_price].price + services[0][:service_price].price + services[1][:service_price].price

      expect(p.cost).to be(expected_cost)
    end

    it 'calculates expected cost with no services' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]
      p = FactoryGirl.create(:participant, days: [d1[:day]], services: [])

      expect(p.cost).to be(d1[:day_price].price)
    end

    it 'calculates expected deadline before end_date of pricing period' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]

      Timecop.travel(Time.parse('2015-10-01'))
      p = FactoryGirl.create(:participant, days: [d1[:day]])
      expect(p.payment_deadline).to be(Time.now + 7.days)
    end

    it 'calculates expected deadline after end_date of pricing period' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]

      Timecop.travel(Time.parse('2015-11-10'))
      p = FactoryGirl.create(:participant, days: [d1[:day]])
      expect(p.payment_deadline).to be(Time.parse('2015-11-11'))
    end
  end
end
