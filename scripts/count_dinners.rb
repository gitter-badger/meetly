# script displaying dinners for each status
dinner1 = Service.find_by(name: "Obiad 03.06")
dinner2 = Service.find_by(name: "Obiad 04.06")
sum_dinner1 = 0
sum_dinner2 = 0
puts "---------------Obiad 03.06---------------"
number = Participant.where(status: 0).select {|p| p.services.include? dinner1}.count
puts "Zarejestrowany: #{number}"
sum_dinner1 += number
number = Participant.where(status: 1).select {|p| p.services.include? dinner1}.count
puts "Czekamy: #{number}"
sum_dinner1 += number
number = Participant.where(status: 2).select {|p| p.services.include? dinner1}.count
puts "Nieoplacony: #{number}"

number = Participant.where(status: 3).select {|p| p.services.include? dinner1}.count
puts "OPLACONY: #{number}"
sum_dinner1 += number
number = Participant.where(status: 4).select {|p| p.services.include? dinner1}.count
puts "Przyjechal: #{number}"
sum_dinner1 += number
puts "SUMA: #{sum_dinner1}"
puts "---------------Obiad 04.06---------------"

number = Participant.where(status: 0).select {|p| p.services.include? dinner2}.count
puts "Zarejestrowany: #{number}"
sum_dinner2 += number
number = Participant.where(status: 1).select {|p| p.services.include? dinner2}.count
puts "Czekamy: #{number}"
sum_dinner2 += number
number = Participant.where(status: 2).select {|p| p.services.include? dinner2}.count
puts "Nieoplacony: #{number}"

number = Participant.where(status: 3).select {|p| p.services.include? dinner2}.count
puts "OPLACONY: #{number}"
sum_dinner2 += number
number = Participant.where(status: 4).select {|p| p.services.include? dinner2}.count
puts "Przyjechal: #{number}"
sum_dinner2 += number
puts "SUMA: #{sum_dinner2}"

