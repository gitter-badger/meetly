
Participant.destroy_all

randy = Event.find_by(name: 'Randy Clark 2-4.06');
blaine = Event.find_by(name: 'Blaine Cook 25-27.04');
gary = Event.find_by(name: 'Gary Oates 16-18.05');

d1 = Day.find_by(number: 1, event: randy)
d2   = Day.find_by(number: 2, event: randy)
d3 = Day.find_by(number: 1, event: blaine)
d4 = Day.find_by(number: 1, event: gary)


rrc = Role.find_by(name: 'Uczestnik', event_id: randy.id)
rbc = Role.find_by(name: 'Uczestnik', event_id: blaine.id)
rgo = Role.find_by(name: 'Uczestnik', event_id: gary.id)

s1 = Service.find_by(name: 'Obiad 03.06')
s2 = Service.find_by(name: 'Obiad 04.06')
s3 = Service.find_by(name: 'Noclegi')
s4 = Service.find_by(name: 'Spotkanie liderów 02.06')
s5 = Service.find_by(description: "Obiady 25-27.04")
s6 = Service.find_by(description: "Obiady 16-18.05")

300.times {
  Participant.create!([
    {
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      age: rand(16..36),
      email: FFaker::Internet.email,
      phone: FFaker::PhoneNumber.short_phone_number,
      role: rrc,
      city: FFaker::Address.city,
      days: [d1, d2],
      gender: [:man, :woman].sample,
      event: randy,
      services: [s1, s2, s3, s4].sample(rand(1..4)),
      status: rand(0..4)
    }
  ])
}

100.times {
  Participant.create!([
    {
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      age: rand(16..36),
      email: FFaker::Internet.email,
      phone: FFaker::PhoneNumber.short_phone_number,
      role: rbc,
      city: FFaker::Address.city,
      days: [d3],
      gender: [:man, :woman].sample,
      event: blaine,
      services: [s5].sample(rand(1..1)),
      status: rand(0..4)
    }
  ])
}


100.times {
  Participant.create!([
    {
      first_name: FFaker::Name.first_name,
      last_name: FFaker::Name.last_name,
      age: rand(16..36),
      email: FFaker::Internet.email,
      phone: FFaker::PhoneNumber.short_phone_number,
      role: rgo,
      city: FFaker::Address.city,
      days: [d4],
      gender: [:man, :woman].sample,
      event: gary,
      services: [s6].sample(rand(1..1)),
      status: rand(0..4)
    }
  ])
}

