module ApplicationHelper
  def number_to_pln(number)
    number_to_currency(number, unit: 'PLN', separator: '.', delimiter: '', format: '%n %u')
  end

  def amount_or_zero_pln(value)
    value ? number_to_pln(value) : number_to_pln(0)
  end
end
