#script displaying nights for  each status
dinner1 = Service.find_by(name: "Nocleg1")
dinner2 = Service.find_by(name: "Nocleg2")
sum_dinner1 = 0
sum_dinner2 = 0
puts "---------------Nocleg ALA 29.12---------------"
number = Participant.where(status: 0, gender: 1).select {|p| p.services.include? dinner1}.count
puts "Zarejestrowany: #{number}"
sum_dinner1 += number
number = Participant.where(status: 1, gender: 1).select {|p| p.services.include? dinner1}.count
puts "Czekamy: #{number}"
sum_dinner1 += number
number = Participant.where(status: 2, gender: 1).select {|p| p.services.include? dinner1}.count
puts "Nieoplacony: #{number}"

number = Participant.where(status: 3, gender: 1).select {|p| p.services.include? dinner1}.count
puts "OPLACONY: #{number}"
sum_dinner1 += number
number = Participant.where(status: 4, gender: 1).select {|p| p.services.include? dinner1}.count
puts "Przyjechal: #{number}"
sum_dinner1 += number
puts "SUMA: #{sum_dinner1}"
puts "---------------Nocleg ALA 30.12---------------"

number = Participant.where(status: 0, gender: 1).select {|p| p.services.include? dinner2}.count
puts "Zarejestrowany: #{number}"
sum_dinner2 += number
number = Participant.where(status: 1, gender: 1).select {|p| p.services.include? dinner2}.count
puts "Czekamy: #{number}"
sum_dinner2 += number
number = Participant.where(status: 2, gender: 1).select {|p| p.services.include? dinner2}.count
puts "Nieoplacony: #{number}"

number = Participant.where(status: 3, gender: 1).select {|p| p.services.include? dinner2}.count
puts "OPLACONY: #{number}"
sum_dinner2 += number
number = Participant.where(status: 4, gender: 1).select {|p| p.services.include? dinner2}.count
puts "Przyjechal: #{number}"
sum_dinner2 += number
puts "SUMA: #{sum_dinner2}"

