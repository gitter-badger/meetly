# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.destroy_all
Participant.destroy_all
PriceTable.destroy_all
Day.destroy_all
Night.destroy_all
Dinner.destroy_all
User.destroy_all

d1 = Day.create!(number: 1)
d2 = Day.create!(number: 2)
d3 = Day.create!(number: 3)

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
			name: 'Bartek',
			surname: 'Szczepanski',
      age: 24,
      email: 'szczepan97@gmail.com',
      phone: '664752055',
			role: ro,
			city: 'Wroclaw',
			nights: [],
			dinners: [dn1, dn2],
			days: [d1, d2, d3],
      gender: 'M'
		}
	])