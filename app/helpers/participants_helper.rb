module ParticipantsHelper
  def polish_humanized_gender(gender)
    case gender
    when 'man'
      'Mężczyzna'
    when 'woman'
      'Kobieta'
    end
  end
end
