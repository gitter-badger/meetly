require 'rails_helper'

describe Participant, type: :model do
  describe 'Participant' do
    before(:each) do
      FactoryGirl.create(:event)
    end

    it 'has a valid factory' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2017, 11, 11), 90
      participant = FactoryGirl.create(:participant)
      participant.role_id = Role.first.id
      expect().to be_valid
    end

    it 'is invalid without first name' do
      expect(FactoryGirl.build(:participant, first_name: nil)).to_not be_valid
    end

    it 'is invalid without last name' do
      expect(FactoryGirl.build(:participant, last_name: nil)).to_not be_valid
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

      # services = FactoryHelper.create_services_with_group 'dinners', 2, 10, db[:role]
      sg = FactoryGirl.create(:service_group, name: 'dinners')
      s1 = FactoryGirl.create(:service, name: 'dinner1', service_group: sg)
      sp1 = FactoryGirl.create(:service_price, price: 10, role: db[:role], service: s1)

      d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]
      d2 = FactoryHelper.create_day_with_price 2, 60, db[:pricing_period], db[:role]
      d3 = FactoryHelper.create_day_with_price 3, 60, db[:pricing_period], db[:role]

      p = FactoryGirl.create(:participant, days: [d1[:day], d2[:day]], services: [s1])

      expected_cost = d1[:day_price].price + d2[:day_price].price + sp1.price #+ services[1][:service_price].price

      expect(p.cost).to be(expected_cost)
    end

    it 'calculates expected cost with no services' do
      db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]
      p = FactoryGirl.create(:participant, days: [d1[:day]], services: [])

      expect(p.cost).to be(d1[:day_price].price)
    end

    it 'calculates expected deadline before end_date of pricing period' do
      # db = FactoryHelper.setup_database Date.new(2015, 9, 1), Date.new(2015, 11, 11), 90
      # d1 = FactoryHelper.create_day_with_price 1, 40, db[:pricing_period], db[:role]
      u = User.create!(name: 'admin', email: 'admin@poczatek.org', password: 'pcztk2015')
      puts "User #{u.name} craeted!"
      e = Event.create!(name: 'Poczatek15/16',
               start_date: Date.new(2015,12,29), end_date: Date.new(2015, 12,31), owner: u)
      puts "Event #{e.name} created!"

      pp = PricingPeriod.create!(name: 'turboprzedplata', event: e, start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
      puts "PricingPeriod #{pp.name} created!"

      r = Role.create!(
        name: 'Uczestnik',
        event_id: e.id
        )
      puts "Role #{r.name} created!"
      sg = ServiceGroup.create!(name: 'Obiady')
      s1 = Service.create!(name: 'Obiad1', event: e, service_group: sg)
      s2 = Service.create!(name: 'Obiad2', event: e, service_group: sg)
      sp1 = ServicePrice.create!(price: 10, role: r, service: s1)
      sp2 = ServicePrice.create!(price: 10, role: r, service: s2)
      puts "Services #{sg.name} created!"
      d1 = Day.create!(number: 1, event: e)
      d2 = Day.create!(number: 2, event: e)
      d3 = Day.create!(number: 3, event: e)
      dp1 = DayPrice.create!(price: 40, pricing_period: pp, role: r, day: d1)
      dp2 = DayPrice.create!(price: 60, pricing_period: pp, role: r, day: d2)
      dp3 = DayPrice.create!(price: 60, pricing_period: pp, role: r, day: d3)

      Timecop.travel(Time.parse('2015-10-01'))
      p = Participant.create!(
        first_name: 'Bartek',
        last_name: 'Szczepanski',
        age: 24,
        email: 'szczepan97@gmail.com',
        phone: '664752055',
        role: r,
        city: 'Wroclaw',
        days: [d1, d2, d3],
        gender: 'man',
        event: e,
        services: [s1, s2],
        status: 'created'
        )
      expect(p.payment_deadline).to be(Time.now.to_date + 7.days)
    end

    it 'calculates expected deadline after end_date of pricing period' do

      load "#{Rails.root}/db/seeds.rb"

      # u = User.create!(name: 'admin', email: 'admin@poczatek.org', password: 'pcztk2015')
      # puts "User #{u.name} craeted!"
      # e = Event.create!(name: 'Poczatek15/16',
      #          start_date: Date.new(2015,12,29), end_date: Date.new(2015, 12,31), owner: u)
      # puts "Event #{e.name} created!"

      # pp = PricingPeriod.create!(name: 'turboprzedplata', event: e, start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
      # puts "PricingPeriod #{pp.name} created!"

      # r = Role.create!(
      #   name: 'Uczestnik',
      #   event_id: e.id
      #   )
      # puts "Role #{r.name} created!"
      # sg = ServiceGroup.create!(name: 'Obiady')
      # s1 = Service.create!(name: 'Obiad1', event: e, service_group: sg)
      # s2 = Service.create!(name: 'Obiad2', event: e, service_group: sg)
      # sp1 = ServicePrice.create!(price: 10, role: r, service: s1)
      # sp2 = ServicePrice.create!(price: 10, role: r, service: s2)
      # puts "Services #{sg.name} created!"
      d1 = Day.create!(number: 4, event: Event.first)
      d2 = Day.create!(number: 5, event: Event.first)
      d3 = Day.create!(number: 6, event: Event.first)
      dp1 = DayPrice.create!(price: 40, pricing_period: PricingPeriod.first, role: Role.first, day: d1)
      dp2 = DayPrice.create!(price: 60, pricing_period: PricingPeriod.first, role: Role.first, day: d2)
      dp3 = DayPrice.create!(price: 60, pricing_period: PricingPeriod.first, role: Role.first, day: d3)

      Timecop.travel(Time.parse('2015-11-10'))
      p = Participant.create!(
        first_name: 'Bartek',
        last_name: 'Szczepanski',
        age: 24,
        email: 'szczepan97@gmail.com',
        phone: '664752055',
        role: Role.first,
        city: 'Wroclaw',
        days: [d1, d2, d3],
        gender: 'man',
        event: Event.first,
        services: [],
        status: 'created'
        )
      expect(p.payment_deadline).to be == Time.utc(2015, 11, 11)
    end
  end
end
