participants = Participant.all

participants.each do |participant|
	date = participant.created_at
	deadline = date + 7.days
	participant.payment_deadline = deadline
	participant.save
end