day1 = Day.find_by(number: 1)
day2 = Day.find_by(number: 2)
day3 = Day.find_by(number: 3)

puts "Dzien 29.12 i 30.12 bez 31.12"
number = Participant.where(status: 0).select { |p| (p.days.include? day1) && (p.days.include? day2) && !(p.days.include? day3)}.count
puts "ZAREJESTROWANI: #{number}"
sum_d1d2 = number

number = Participant.where(status: 3).select { |p| (p.days.include? day1) && (p.days.include? day2) && !(p.days.include? day3)}.count
puts "OPLACENI: #{number}"
sum_d1d2 += number

puts "SUMA: #{sum_d1d2}"
