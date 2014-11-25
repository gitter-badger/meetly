pt = PriceTable.create!(
	name: 'Organizatorzy',
	days: 0,
	day1: 0,
	day2: 0,
	day3: 0,
	night: 0,
	dinner: 0
	)

org = Role.find_by(name: 'Organizator')
org.price_table = pt
org.save!

pt2 = PriceTable.create!(
    name: 'Wolntariusze',
    days: 50,
    day1: 10,
    day2: 10,
    day3: 30,
    night: 0,
    dinner: 15
)

wolont = Role.create!(
	name: 'Wolontariusz',
	price_table: pt2
	)
