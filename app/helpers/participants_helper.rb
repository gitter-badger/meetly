module ParticipantsHelper
  def participants_payments_sum
    "#{participants.sum('paid').to_i} zł"
  end

  def participants_participance_costs_sum
    "#{participants.sum('cost').to_i} zł"
  end

  def participants_registered_today
    participants.created.select { |participant| participant.created_at.to_date == Date.today  }
  end
end
