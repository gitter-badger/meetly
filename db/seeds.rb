# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.destroy_all
Participant.unscoped.destroy_all
PriceTable.destroy_all
Day.destroy_all
Night.destroy_all
Dinner.destroy_all
Event.destroy_all
User.destroy_all
Service.destroy_all
ServiceGroup.destroy_all
PricingPeriod.destroy_all

u = User.create!(name: 'Marcela', email: 'marcela@poczatek.org', password: 'password')
#  validates :name, :start_date, :end_date, :owner_id, presence: true

e = Event.create!(name: 'Poczatek15/16', 
						start_date: Date.new(2015,12,29), end_date: Date.new(2015, 12,31), owner: u)


pp = PricingPeriod.create!(name: 'turboprzedplata', event: e, start_date: Date.new(2015, 10, 1), end_date: Date.new(2015, 11, 11))

sg = ServiceGroup.create!(name: 'Obiady')
s1 = Service.create!(name: 'Obiad1', event: e, service_group: sg, price: 10)
s2 = Service.create!(name: 'Obiad2', event: e, service_group: sg, price: 10)

d1 = Day.create!(number: 1, event: e)
d2 = Day.create!(number: 2, event: e)
d3 = Day.create!(number: 3, event: e)

n1 = Night.create!(number: 1)
n2 = Night.create!(number: 2)

dn1=Dinner.create!(number:1)
dn2 = Dinner.create!(number:2)

pt = PriceTable.create!(
	name: 'Podstawowa',
	days: 99,
	day1: 20,
	day2: 40,
	day3: 60,
	night: 10,
	dinner: 15
	)

pt2 = PriceTable.create!(
    name: 'PodstawowaPo5',
    days: 120,
    day1: 20,
    day2: 40,
    day3: 60,
    night: 10,
    dinner: 15
)


ru = Role.create!(
	name: 'Uczestnik',
	price_table: pt
	)

ro = Role.create!(
	name: 'Organizator',
	price_table: pt
	)

Participant.create!([
		{
			first_name: 'Bartek',
			last_name: 'Szczepanski',
      age: 24,
      email: 'szczepan97@gmail.com',
      phone: '664752055',
			role: ro,
			city: 'Wroclaw',
			nights: [],
			dinners: [dn1, dn2],
			days: [d1, d2, d3],
      gender: 'M',
      event: e,
      services: [s1, s2]
		}
	])

Participant.create!([
		{
			first_name: 'Bartek1',
			last_name: 'Szczepanski',
      age: 24,
      email: 'szczepan97@gmail.com',
      phone: '664752055',
			role: ro,
			city: 'Wroclaw',
			nights: [],
			dinners: [dn1, dn2],
			days: [d1, d2, d3],
      gender: 'M',
      event: e
		}
	])

Participant.create!([
		{
			first_name: 'Bartek2',
			last_name: 'Szczepanski',
      age: 24,
      email: 'szczepan97@gmail.com',
      phone: '664752055',
			role: ro,
			city: 'Wroclaw',
			nights: [],
			dinners: [dn1, dn2],
			days: [d1, d2, d3],
      gender: 'M',
      event: e
		}
	])

