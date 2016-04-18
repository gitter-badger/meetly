
u = User.find_by(name: 'jestwiecej')

puts "User #{u.name} found!"
e = Event.create!(name: 'Sukkot Kalisz 16-23.10.2016', start_date: Date.new(2016,10,16), end_date: Date.new(2016,10,23), owner: u, capacity: 1000, days_to_pay: 7)
puts "Event #{e.name} created!"


pp = PricingPeriod.create!(name: 'Pierwszy termin SukkotKal', event: e, start_date: Date.new(2016, 1,1), end_date: Date.new(2016, 10, 30))
puts "PricingPeriod #{pp.name} created!"


r = Role.create!(
  name: 'Uczestnik',
  event_id: e.id
  )

puts "Role #{r.name} created!"


ep = EventPrice.create!(pricing_period: pp, role: r, event: e, price: 70.0, currency: "PLN")

sg = ServiceGroup.create!(name: 'Obiady Sukkot Kalisz')
s1 = Service.create!(name: 'Obiad 17.10', event: e, service_group: sg, description: "Obiad 17.10")
sp1 = ServicePrice.create!(price: 15, role: r, service: s1, currency: "PLN")
s2 = Service.create!(name: 'Obiad 18.10', event: e, service_group: sg, description: "Obiad 18.10")
sp2 = ServicePrice.create!(price: 15, role: r, service: s2, currency: "PLN")
s3 = Service.create!(name: 'Obiad 19.10', event: e, service_group: sg, description: "Obiad 19.10")
sp3 = ServicePrice.create!(price: 15, role: r, service: s3, currency: "PLN")
s4 = Service.create!(name: 'Obiad 20.10', event: e, service_group: sg, description: "Obiad 20.10")
sp4 = ServicePrice.create!(price: 15, role: r, service: s4, currency: "PLN")
s5 = Service.create!(name: 'Obiad 21.10', event: e, service_group: sg, description: "Obiad 21.10")
sp5 = ServicePrice.create!(price: 15, role: r, service: s5, currency: "PLN")
s6 = Service.create!(name: 'Obiad 22.10', event: e, service_group: sg, description: "Obiad 22.10")
sp6 = ServicePrice.create!(price: 15, role: r, service: s6, currency: "PLN")
s7 = Service.create!(name: 'Obiad 23.10', event: e, service_group: sg, description: "Obiad 23.10")
sp7 = ServicePrice.create!(price: 15, role: r, service: s7, currency: "PLN")


sg = ServiceGroup.create!(name: 'Kolacje Sukkot Kalisz')
s0 = Service.create!(name: 'Kolacja 16.10', event: e, service_group: sg, description: "Kolacja 16.10")
sp0 = ServicePrice.create!(price: 20, role: r, service: s0, currency: "PLN")
s1 = Service.create!(name: 'Kolacja 17.10', event: e, service_group: sg, description: "Kolacja 17.10")
sp1 = ServicePrice.create!(price: 20, role: r, service: s1, currency: "PLN")
s2 = Service.create!(name: 'Kolacja 18.10', event: e, service_group: sg, description: "Kolacja 18.10")
sp2 = ServicePrice.create!(price: 20, role: r, service: s2, currency: "PLN")
s3 = Service.create!(name: 'Kolacja 19.10', event: e, service_group: sg, description: "Kolacja 19.10")
sp3 = ServicePrice.create!(price: 20, role: r, service: s3, currency: "PLN")
s4 = Service.create!(name: 'Kolacja 20.10', event: e, service_group: sg, description: "Kolacja 20.10")
sp4 = ServicePrice.create!(price: 20, role: r, service: s4, currency: "PLN")
s5 = Service.create!(name: 'Kolacja 21.10', event: e, service_group: sg, description: "Kolacja 21.10")
sp5 = ServicePrice.create!(price: 20, role: r, service: s5, currency: "PLN")
s6 = Service.create!(name: 'Kolacja 22.10', event: e, service_group: sg, description: "Kolacja 22.10")
sp6 = ServicePrice.create!(price: 20, role: r, service: s6, currency: "PLN")
s7 = Service.create!(name: 'Kolacja 23.10', event: e, service_group: sg, description: "Kolacja 23.10")
sp7 = ServicePrice.create!(price: 20, role: r, service: s7, currency: "PLN")

d1 = Day.create!(number: 1, event: e, display_name: "16.10")
dp1 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d1, currency: "PLN")
d2 = Day.create!(number: 2, event: e, display_name: "17.10")
dp2 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d2, currency: "PLN")
d3 = Day.create!(number: 3, event: e, display_name: "18.10")
dp3 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d3, currency: "PLN")
d4 = Day.create!(number: 4, event: e, display_name: "19.10")
dp4 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d4, currency: "PLN")
d5 = Day.create!(number: 5, event: e, display_name: "20.10")
dp5 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d5, currency: "PLN")
d6 = Day.create!(number: 6, event: e, display_name: "21.10")
dp6 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d6, currency: "PLN")
d7 = Day.create!(number: 7, event: e, display_name: "22.10")
dp7 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d7, currency: "PLN")
d8 = Day.create!(number: 8, event: e, display_name: "23.10")
dp8 = DayPrice.create!(price: 20.0, pricing_period: pp, role: r, day: d8, currency: "PLN")

sg = ServiceGroup.find_by(name: 'Dodatkowe')
s1 = Service.create!(name: 'Informacje o kolejnych wydarzeniach', event: e, service_group: sg, description: "Zgoda na informacje o kolejnych wydarzeniach")
ServicePrice.create!(price: 0, role: r, service: s1)

