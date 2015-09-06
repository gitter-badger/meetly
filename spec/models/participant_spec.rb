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

      sg = FactoryGirl.create(:service_group, name: 'dinners')
      s1 = FactoryGirl.create(:service, name: 'dinner1', service_group: sg)
      s2 = FactoryGirl.create(:service, name: 'dinner2', service_group: sg)
      sp1 = FactoryGirl.create(:service_price, price: 10, role: db['role'], service: s1)
      sp2 = FactoryGirl.create(:service_price, price: 10, role: db['role'], service: s2)

      d1 = FactoryGirl.create(:day, number: 1)
      d2 = FactoryGirl.create(:day, number: 2)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: db['pricing_period'], role: db['role'], day: d1)
      dp2 = FactoryGirl.create(:day_price, price: 60, pricing_period: db['pricing_period'], role: db['role'], day: d2)

      p = FactoryGirl.create(:participant, days: [d1, d2], services: [s1, s2])

      expected_cost = db['event_price'].price + sp1.price + sp2.price

      expect(p.cost).to be(expected_cost)
    end

    it 'calculates expected cost for single days' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90

      sg = FactoryGirl.create(:service_group, name: 'dinners')
      s1 = FactoryGirl.create(:service, name: 'dinner1', service_group: sg)
      s2 = FactoryGirl.create(:service, name: 'dinner2', service_group: sg)
      sp1 = FactoryGirl.create(:service_price, price: 10, role: db['role'], service: s1)
      sp2 = FactoryGirl.create(:service_price, price: 10, role: db['role'], service: s2)

      d1 = FactoryGirl.create(:day, number: 1)
      d2 = FactoryGirl.create(:day, number: 2)
      d3 = FactoryGirl.create(:day, number: 3)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: db['pricing_period'], role: db['role'], day: d1)
      dp2 = FactoryGirl.create(:day_price, price: 60, pricing_period: db['pricing_period'], role: db['role'], day: d2)
      dp3 = FactoryGirl.create(:day_price, price: 60, pricing_period: db['pricing_period'], role: db['role'], day: d3)

      p = FactoryGirl.create(:participant, days: [d1, d2], services: [s1, s2])

      expected_cost = dp1.price + dp2.price + sp1.price + sp2.price

      expect(p.cost).to be(expected_cost)
    end

    it 'calculates expected cost with no services' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      d1 = FactoryGirl.create(:day, number: 1)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: db['pricing_period'], role: db['role'], day: d1)
      p = FactoryGirl.create(:participant, days: [d1], services: [])

      expect(p.cost).to be(dp1.price)
    end

    it 'calculates expected deadline before end_date of pricing period' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      d1 = FactoryGirl.create(:day, number: 1)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: db['pricing_period'], role: db['role'], day: d1)

      Timecop.travel(Time.parse('2015-10-01'))
      p = FactoryGirl.create(:participant, days: [d1])
      expect(p.payment_deadline).to be(Time.now + 7.days)
    end

    it 'calculates expected deadline after end_date of pricing period' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      d1 = FactoryGirl.create(:day, number: 1)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: db['pricing_period'], role: db['role'], day: d1)

      Timecop.travel(Time.parse('2015-11-10'))
      p = FactoryGirl.create(:participant, days: [d1])
      expect(p.payment_deadline).to be(Time.parse('2015-11-11'))
    end
  end
end
