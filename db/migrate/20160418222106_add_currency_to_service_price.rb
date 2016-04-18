class AddCurrencyToServicePrice < ActiveRecord::Migration
  def change
    add_column :service_prices, :currency, :string, default: "PLN"
  end
end
