module ApplicationHelper
  def number_to_curr(number, currency)
    unit = currency || 'PLN'
    number_to_currency(number, unit: unit, separator: '.', delimiter: '', format: '%n %u')
  end

  def amount_or_zero_curr(value, currency)
    value ? number_to_curr(value, currency) : number_to_pln(0, currency)
  end
end
