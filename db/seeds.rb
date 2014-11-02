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

d1 = Day.create!(number: 1)
d2 = Day.create!(number: 2)
d3 = Day.create!(number: 3)

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
			nights: 0,
			dinners: 2,
			days: [d1, d2, d3],
      gender: true
		},
		{
			name: 'Pawel',
			surname: 'Zachanowicz',
      age: 49,
      email: 'pz@zachan.com',
      phone: 'TOP SECRET',
			role: ru,
			city: 'Wroclaw',
			nights: 0,
			dinners: 0,
			days: [d1, d2, d3],
      gender: true
		}

	])