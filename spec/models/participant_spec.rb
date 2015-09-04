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

    it 'calculates expected cost for whole event' do
      u = FactoryGirl.create(:user, name: 'admin')
      e = FactoryGirl.create(:event, name: 'event', owner: u)
      r = FactoryGirl.create(:role, name: 'participant')
      pp = FactoryGirl.create(:pricing_period, name: 'first', start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
      ep = FactoryGirl.create(:event_price, price: 90, pricing_period: pp, role: r, event: e)
      sg = FactoryGirl.create(:service_group, name: 'dinners')
      s1 = FactoryGirl.create(:service, name: 'dinner1', service_group: sg)
      s2 = FactoryGirl.create(:service, name: 'dinner2', service_group: sg)
      sp1 = FactoryGirl.create(:service_price, price: 10, role: r, service: s1)
      sp2 = FactoryGirl.create(:service_price, price: 10, role: r, service: s2)

      d1 = FactoryGirl.create(:day, number: 1)
      d2 = FactoryGirl.create(:day, number: 2)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: pp, role: r, day: d1)
      dp2 = FactoryGirl.create(:day_price, price: 60, pricing_period: pp, role: r, day: d2)

      p = FactoryGirl.create(:participant, days: [d1, d2], services: [s1, s2])

      expected_cost = ep.price + sp1.price + sp2.price

      expect(p.cost).to be(expected_cost)
    end

    it 'calculates expected cost for single days' do
      u = FactoryGirl.create(:user, name: 'admin')
      e = FactoryGirl.create(:event, name: 'event', owner: u)
      r = FactoryGirl.create(:role, name: 'participant')
      pp = FactoryGirl.create(:pricing_period, name: 'first', start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
      ep = FactoryGirl.create(:event_price, price: 90, pricing_period: pp, role: r, event: e)
      sg = FactoryGirl.create(:service_group, name: 'dinners')
      s1 = FactoryGirl.create(:service, name: 'dinner1', service_group: sg)
      s2 = FactoryGirl.create(:service, name: 'dinner2', service_group: sg)
      sp1 = FactoryGirl.create(:service_price, price: 10, role: r, service: s1)
      sp2 = FactoryGirl.create(:service_price, price: 10, role: r, service: s2)

      d1 = FactoryGirl.create(:day, number: 1)
      d2 = FactoryGirl.create(:day, number: 2)
      d3 = FactoryGirl.create(:day, number: 3)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: pp, role: r, day: d1)
      dp2 = FactoryGirl.create(:day_price, price: 60, pricing_period: pp, role: r, day: d2)
      dp3 = FactoryGirl.create(:day_price, price: 60, pricing_period: pp, role: r, day: d3)

      p = FactoryGirl.create(:participant, days: [d1, d2], services: [s1, s2])

      expected_cost = dp1.price + dp2.price + sp1.price + sp2.price

      expect(p.cost).to be(expected_cost)
    end

    it 'calculates expected deadline before end_date of pricing period' do
      u = FactoryGirl.create(:user, name: 'admin')
      e = FactoryGirl.create(:event, name: 'event', owner: u)
      r = FactoryGirl.create(:role, name: 'participant')
      pp = FactoryGirl.create(:pricing_period, name: 'first', start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
      ep = FactoryGirl.create(:event_price, price: 90, pricing_period: pp, role: r, event: e)
      d1 = FactoryGirl.create(:day, number: 1)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: pp, role: r, day: d1)

      Timecop.travel(Time.parse('2015-10-01'))
      p = FactoryGirl.create(:participant, days: [d1])
      expect(p.payment_deadline).to be(Time.now + 7.days)
    end

    it 'calculates expected deadline after end_date of pricing period' do
      u = FactoryGirl.create(:user, name: 'admin')
      e = FactoryGirl.create(:event, name: 'event', owner: u)
      r = FactoryGirl.create(:role, name: 'participant')
      pp = FactoryGirl.create(:pricing_period, name: 'first', start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
      ep = FactoryGirl.create(:event_price, price: 90, pricing_period: pp, role: r, event: e)
      d1 = FactoryGirl.create(:day, number: 1)
      dp1 = FactoryGirl.create(:day_price, price: 40, pricing_period: pp, role: r, day: d1)

      Timecop.travel(Time.parse('2015-11-10'))
      p = FactoryGirl.create(:participant, days: [d1])
      expect(p.payment_deadline).to be(Time.parse('2015-11-11'))
    end
  end
end
