Participant.all.each do |p|
  p.registration_date = p.created_at
  p.save
end
