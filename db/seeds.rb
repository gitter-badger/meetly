# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Clearing DB..."
Role.destroy_all
Participant.destroy_all
Day.destroy_all
DayPrice.destroy_all
Event.destroy_all
EventPrice.destroy_all
User.destroy_all
Service.destroy_all
ServicePrice.destroy_all
ServiceGroup.destroy_all
PricingPeriod.destroy_all

u = User.create!(name: 'admin', email: 'admin@poczatek.org', password: 'pcztk2015')
puts "User #{u.name} craeted!"
e = Event.create!(name: 'Poczatek', 
						start_date: Date.new(2015,12,29), end_date: Date.new(2015, 12,31), owner: u, capacity: 20)
puts "Event #{e.name} created!"

pp = PricingPeriod.create!(name: 'turboprzedplata', event: e, start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
puts "PricingPeriod #{pp.name} created!"

r = Role.create!(
  name: 'Uczestnik',
  event_id: e.id
  )
puts "Role #{r.name} created!"

ep = EventPrice.create!(pricing_period: pp, role: r, event: e, price: 140)
puts "Event price created!"

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
puts "Days created!"
Participant.create!([
		{
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
      services: [s1, s2]
		}
	])
puts "Bartek created!"
Participant.create!([
    {
      first_name: 'Dawid',
      last_name: 'Leszczynski',
      age: 24,
      email: 'davebream@gmail.com',
      phone: '555555555',
      role: r,
      city: 'Wroclaw',
      days: [d1, d2],
      gender: 'man',
      event: e,
      services: [s1]
    }
  ])
puts "Dawid created!"
