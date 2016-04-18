class AddCurrencyToDayPrice < ActiveRecord::Migration
  def change
    add_column :day_prices, :currency, :string, default: "PLN"
  end
end
