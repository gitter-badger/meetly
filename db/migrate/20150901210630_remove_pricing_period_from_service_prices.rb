class RemovePricingPeriodFromServicePrices < ActiveRecord::Migration
  def change
  	remove_column :service_prices, :pricing_period_id, :integer
  end
end
