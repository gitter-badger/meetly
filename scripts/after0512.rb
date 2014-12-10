#script to create new table for UczestnikPo5
p = PriceTable.create!(
	name: 'PodstawowaPo1012',
	days: 120,
	day1: 20,
	day2: 40,
	day3: 60,
	night: 10,
	dinner: 15
	)
r = Role.create!(
	name: 'UczestnikPo1012',
	price_table: p
	)