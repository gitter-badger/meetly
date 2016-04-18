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

u = User.create!(name: 'jestwiecej', email: 'biuro@jestwiecej.org', password: 'poczatek2016')
puts "User #{u.name} created!"
e = Event.create!(name: 'Randy Clark 2-4.06', start_date: Date.new(2016,6,2), end_date: Date.new(2015,6,4), owner: u, capacity: 4000, days_to_pay: 7)
puts "Event #{e.name} created!"

pp = PricingPeriod.create!(name: 'Pierwszy termin', event: e, start_date: Date.new(2016, 1,1), end_date: Date.new(2016, 3, 1))
puts "PricingPeriod #{pp.name} created!"
pp2 = PricingPeriod.create!(name: 'Drugi termin', event: e, start_date: Date.new(2016, 3,1), end_date: Date.new(2016, 5, 1))
puts "PricingPeriod #{pp2.name} created!"
pp3 = PricingPeriod.create!(name: 'Trzeci termin', event: e, start_date: Date.new(2016, 5, 1), end_date: Date.new(2016, 6, 6))
puts "PricingPeriod #{pp3.name} created!"

r = Role.create!(
  name: 'Uczestnik',
  event_id: e.id
  )

puts "Role #{r.name} created!"

ep = EventPrice.create!(pricing_period: pp, role: r, event: e, price: 120.0)
ep = EventPrice.create!(pricing_period: pp2, role: r, event: e, price: 160.0)
ep = EventPrice.create!(pricing_period: pp3, role: r, event: e, price: 200.0)

sg = ServiceGroup.create!(name: 'Obiady')
s1 = Service.create!(name: 'Obiad 03.06', event: e, service_group: sg, description: "Obiad 1 - Dzień 03.06")
s2 = Service.create!(name: 'Obiad 04.06', event: e, service_group: sg, description: "Obiad 2 - Dzień 04.06")
sp1 = ServicePrice.create!(price: 10, role: r, service: s1)
sp2 = ServicePrice.create!(price: 10, role: r, service: s2)
puts "Services #{sg.name} created!"

sg2 = ServiceGroup.create!(name: 'Noclegi')
s12 = Service.create!(name: 'Noclegi', event: e, service_group: sg2, description: "Nocleg w internaci")
sp12 = ServicePrice.create!(price: 35, role: r, service: s12)
puts "Services #{sg2.name} created!"

sg3 = ServiceGroup.create!(name: 'Spotkanie liderów')
s13 = Service.create!(name: 'Spotkanie liderów 02.06', event: e, service_group: sg3, description: "Spotkanie liderów")
sp13 = ServicePrice.create!(price: 100, role: r, service: s13)
puts "Services #{sg3.name} created!"

d1 = Day.create!(number: 1, event: e, display_name: "03.06")
d2 = Day.create!(number: 2, event: e, display_name: "04.06")
dp1 = DayPrice.create!(price: 60.0, pricing_period: pp, role: r, day: d1)
dp2 = DayPrice.create!(price: 60.0, pricing_period: pp, role: r, day: d2)
dp1 = DayPrice.create!(price: 80.0, pricing_period: pp2, role: r, day: d1)
dp2 = DayPrice.create!(price: 80.0, pricing_period: pp2, role: r, day: d2)
dp1 = DayPrice.create!(price: 100.0, pricing_period: pp3, role: r, day: d1)
dp2 = DayPrice.create!(price: 100.0, pricing_period: pp3, role: r, day: d2)

puts "Days created!"
