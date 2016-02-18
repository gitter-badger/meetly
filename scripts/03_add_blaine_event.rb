
u = User.find_by(name: 'jestwiecej')

puts "User #{u.name} found!"
e = Event.create!(name: 'Blaine Cook 25-27.04', start_date: Date.new(2016,4,25), end_date: Date.new(2016,4,27), owner: u, capacity: 1000, days_to_pay: 7)
puts "Event #{e.name} created!"


pp = PricingPeriod.create!(name: 'Pierwszy termin BC', event: e, start_date: Date.new(2016, 1,1), end_date: Date.new(2016, 4, 27))
puts "PricingPeriod #{pp.name} created!"


r = Role.create!(
  name: 'Uczestnik',
  event_id: e.id
  )

puts "Role #{r.name} created!"


ep = EventPrice.create!(pricing_period: pp, role: r, event: e, price: 100.0)

sg = ServiceGroup.create!(name: 'Obiady BC')
s1 = Service.create!(name: 'Obiady', event: e, service_group: sg, description: "Obiady 25-27.04")
sp1 = ServicePrice.create!(price: 45, role: r, service: s1)

d1 = Day.create!(number: 1, event: e, display_name: "Udział w konferencji")
dp1 = DayPrice.create!(price: 100.0, pricing_period: pp, role: r, day: d1)