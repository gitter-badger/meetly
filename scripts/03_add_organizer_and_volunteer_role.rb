
e = Event.find_by_name('Poczatek 15/16')
puts "Found event #{e.name}"
o = Role.find_by_name('Organizator')
o = Role.create!(name: 'Organizator', event_id: e.id) if o == nil
puts "Role #{o.name} created!"
v = Role.find_by_name('Wolontariusz')
v = Role.create!(name: 'Wolontariusz', event_id: e.id) if v == nil
puts "Role #{v.name} created!"

pp1 = PricingPeriod.find_by_name('Pierwszy termin')
puts "PricingPeriod #{pp1.name} found!"
pp2 = PricingPeriod.find_by_name('Drugi termin')
puts "PricingPeriod #{pp2.name} found!"

s1 = Service.find_by_name('Obiad1')
s2 = Service.find_by_name('Obiad2')
s12 = Service.find_by_name('Nocleg1')
s22 = Service.find_by_name('Nocleg2')
d1 = Day.find_by(number:1)
d2 = Day.find_by(number:2)
d3 = Day.find_by(number:3)
puts "days and services found"

# organizator
epo1 = EventPrice.create!(pricing_period: pp1, role: o, event: e, price: 0)
epo2 = EventPrice.create!(pricing_period: pp2, role: o, event: e, price: 0)

spo1 = ServicePrice.create!(price: 0, role: o, service: s1)
spo2 = ServicePrice.create!(price: 0, role: o, service: s2)
spo12 = ServicePrice.create!(price: 0, role: o, service: s12)
spo22 = ServicePrice.create!(price: 0, role: o, service: s22)

dpo11 = DayPrice.create!(price: 0.0, pricing_period: pp1, role: o, day: d1)
dpo21 = DayPrice.create!(price: 0.0, pricing_period: pp1, role: o, day: d2)
dpo31 = DayPrice.create!(price: 0.0, pricing_period: pp1, role: o, day: d3)
dpo12 = DayPrice.create!(price: 0.0, pricing_period: pp2, role: o, day: d1)
dpo22 = DayPrice.create!(price: 0.0, pricing_period: pp2, role: o, day: d2)
dpo32 = DayPrice.create!(price: 0.0, pricing_period: pp2, role: o, day: d3)

puts "Organizer set up finished"

# wolontariusz
epo1 = EventPrice.create!(pricing_period: pp1, role: v, event: e, price: 60)
epo2 = EventPrice.create!(pricing_period: pp2, role: v, event: e, price: 60)

spo1 = ServicePrice.create!(price: 18.0, role: v, service: s1)
spo2 = ServicePrice.create!(price: 18.0, role: v, service: s2)
spo12 = ServicePrice.create!(price: 0, role: v, service: s12)
spo22 = ServicePrice.create!(price: 0, role: v, service: s22)

dpo11 = DayPrice.create!(price: 10.0, pricing_period: pp1, role: v, day: d1)
dpo21 = DayPrice.create!(price: 20.0, pricing_period: pp1, role: v, day: d2)
dpo31 = DayPrice.create!(price: 30.0, pricing_period: pp1, role: v, day: d3)
dpo12 = DayPrice.create!(price: 10.0, pricing_period: pp2, role: v, day: d1)
dpo22 = DayPrice.create!(price: 20.0, pricing_period: pp2, role: v, day: d2)
dpo32 = DayPrice.create!(price: 30.0, pricing_period: pp2, role: v, day: d3)

puts "Volunteer set up finished"
