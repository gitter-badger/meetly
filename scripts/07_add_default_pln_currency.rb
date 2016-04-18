EventPrice.all.each do |ep|
  ep.currency = 'PLN'
  ep.save
end

ServicePrice.all.each do |ep|
  ep.currency = 'PLN'
  ep.save
end

DayPrice.all.each do |ep|
  ep.currency = 'PLN'
  ep.save
end

