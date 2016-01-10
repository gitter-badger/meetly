
e = Event.find_by_name('Randy Clark 2-4.06')
puts "Found event #{e.name}"
o = Role.create!(name: 'Gość', event_id: e.id)
puts "Role #{o.name} created!"

pp1 = PricingPeriod.find_by_name('Pierwszy termin')
puts "PricingPeriod #{pp1.name} found!"
pp2 = PricingPeriod.find_by_name('Drugi termin')
puts "PricingPeriod #{pp2.name} found!"
pp3 = PricingPeriod.find_by_name('Trzeci termin')
puts "PricingPeriod #{pp3.name} found!"

s1 = Service.find_by_name('Obiad 03.06')
s2 = Service.find_by_name('Obiad 04.06')
s12 = Service.find_by_name('Spotkanie liderów 02.06')
s22 = Service.find_by_name('Noclegi')
d1 = Day.find_by(number:1)
d2 = Day.find_by(number:2)
puts "days and services found"

# guest
epo1 = EventPrice.create!(pricing_period: pp1, role: o, event: e, price: 0)
epo2 = EventPrice.create!(pricing_period: pp2, role: o, event: e, price: 0)
epo2 = EventPrice.create!(pricing_period: pp3, role: o, event: e, price: 0)

spo1 = ServicePrice.create!(price: 0, role: o, service: s1)
spo2 = ServicePrice.create!(price: 0, role: o, service: s2)
spo12 = ServicePrice.create!(price: 0, role: o, service: s12)
spo22 = ServicePrice.create!(price: 0, role: o, service: s22)

dpo11 = DayPrice.create!(price: 0.0, pricing_period: pp1, role: o, day: d1)
dpo21 = DayPrice.create!(price: 0.0, pricing_period: pp1, role: o, day: d2)
dpo31 = DayPrice.create!(price: 0.0, pricing_period: pp2, role: o, day: d1)
dpo12 = DayPrice.create!(price: 0.0, pricing_period: pp2, role: o, day: d2)
dpo22 = DayPrice.create!(price: 0.0, pricing_period: pp3, role: o, day: d1)
dpo32 = DayPrice.create!(price: 0.0, pricing_period: pp3, role: o, day: d2)

puts "Guest set up finished"