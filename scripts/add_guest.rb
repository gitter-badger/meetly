p = PriceTable.find_by(name: 'Organizatorzy')

gosc = Role.create!(
	name: 'Gość',
	price_table: p
	)
