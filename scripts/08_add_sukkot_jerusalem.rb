
u = User.find_by(name: 'jestwiecej')

puts "User #{u.name} found!"
e = Event.create!(name: 'Sukkot Jerozolima 15-24.10.2016', start_date: Date.new(2016,10,15), end_date: Date.new(2016,10,24), owner: u, capacity: 1000, days_to_pay: 7)
puts "Event #{e.name} created!"


pp = PricingPeriod.create!(name: 'Pierwszy termin SukkotJer', event: e, start_date: Date.new(2016, 1,1), end_date: Date.new(2016, 10, 30))
puts "PricingPeriod #{pp.name} created!"


r = Role.create!(
  name: 'Uczestnik',
  event_id: e.id
  )

puts "Role #{r.name} created!"


ep = EventPrice.create!(pricing_period: pp, role: r, event: e, price: 100.0, currency: "USD")

sg = ServiceGroup.find_by(name: 'Dodatkowe')
s1 = Service.create!(name: 'Informacje o kolejnych wydarzeniach', event: e, service_group: sg, description: "Zgoda na informacje o kolejnych wydarzeniach")
ServicePrice.create!(price: 0, role: r, service: s1)

d1 = Day.create!(number: 1, event: e, display_name: "16-23.10.2016")
dp1 = DayPrice.create!(price: 100.0, currency: "USD", pricing_period: pp, role: r, day: d1)
