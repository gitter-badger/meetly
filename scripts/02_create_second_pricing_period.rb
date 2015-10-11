
e = Event.find_by_name('Poczatek 15/16')
puts "Found event #{e.name}"

r = Role.find_by_name('Uczestnik')
puts "Found role #{r.name}"

pp = PricingPeriod.create!(name: 'Drugi termin', event: e, start_date: Date.new(2015, 12, 11), end_date: Date.new(2015, 12, 31))
puts "PricingPeriod #{pp.name} created!"

ep = EventPrice.create!(pricing_period: pp, role: r, event: e, price: 129.0)
puts "Event price for first period and 'Uczestnik' role created!"

d1 = Day.create!(number: 1, event: e)
d2 = Day.create!(number: 2, event: e)
d3 = Day.create!(number: 3, event: e)
dp1 = DayPrice.create!(price: 0.0, pricing_period: pp, role: r, day: d1)
dp2 = DayPrice.create!(price: 59.0, pricing_period: pp, role: r, day: d2)
dp3 = DayPrice.create!(price: 79.0, pricing_period: pp, role: r, day: d3)
