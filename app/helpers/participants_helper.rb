module ParticipantsHelper
  def participants_payments_sum
    "#{participants.active.sum('paid').to_i} zł"
  end

  def participants_participance_costs_sum
    "#{participants.active.sum('cost').to_i} zł"
  end

  def participants_registered_today
    participants.created.select { |participant| participant.registration_date.to_date == Date.today  }
  end
end
