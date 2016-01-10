Participant.where(status: 0).each do |p|
	if(p.payment_deadline - DateTime.now < 0)
		puts "Changing status to unpaid for #{p.first_name} #{p.last_name}..."
		p.status = 2
		p.save
	end
end

