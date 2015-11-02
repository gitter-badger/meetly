# script for first database seed with production data
puts "Clearing database..."
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
puts "User #{u.name} created!"
e = Event.create!(name: 'Poczatek 15/16', start_date: Date.new(2015,12,29), end_date: Date.new(2015, 12,31), owner: u, capacity: 700, days_to_pay: 7)
puts "Event #{e.name} created!"

pp = PricingPeriod.create!(name: 'Pierwszy termin', event: e, start_date: Date.new(2015, 10, 1), end_date: Date.new(2015, 12, 10))
puts "PricingPeriod #{pp.name} created!"

r = Role.create!(
  name: 'Uczestnik',
  event_id: e.id
  )

puts "Role #{r.name} created!"

ep = EventPrice.create!(pricing_period: pp, role: r, event: e, price: 99.0)
puts "Event price for first period and 'Uczestnik' role created!"

sg = ServiceGroup.create!(name: 'Obiady')
s1 = Service.create!(name: 'Obiad1', event: e, service_group: sg, description: "Obiad 1 - Dzień 30.12")
s2 = Service.create!(name: 'Obiad2', event: e, service_group: sg, description: "Obiad 2 - Dzień 31.12")
sp1 = ServicePrice.create!(price: 18, role: r, service: s1)
sp2 = ServicePrice.create!(price: 18, role: r, service: s2)
puts "Services #{sg.name} created!"

sg2 = ServiceGroup.create!(name: 'Noclegi')
s12 = Service.create!(name: 'Nocleg1', event: e, service_group: sg2, description: "Nocleg 1 - Dzień 29.12")
s22 = Service.create!(name: 'Nocleg2', event: e, service_group: sg2, description: "Nocleg 2 - Dzień 30.12")
sp12 = ServicePrice.create!(price: 10, role: r, service: s12)
sp22 = ServicePrice.create!(price: 10, role: r, service: s22)
puts "Services #{sg2.name} created!"

d1 = Day.create!(number: 1, event: e)
d2 = Day.create!(number: 2, event: e)
d3 = Day.create!(number: 3, event: e)
dp1 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d1)
dp2 = DayPrice.create!(price: 29.0, pricing_period: pp, role: r, day: d2)
dp3 = DayPrice.create!(price: 69.0, pricing_period: pp, role: r, day: d3)

puts "Days created!"
