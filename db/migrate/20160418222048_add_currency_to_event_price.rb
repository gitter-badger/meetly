class AddCurrencyToEventPrice < ActiveRecord::Migration
  def change
    add_column :event_prices, :currency, :string, default: "PLN"
  end
end
