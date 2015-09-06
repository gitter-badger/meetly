class FactoryHelper
  def self.setup_database(start_date, end_date, event_price)
    u = FactoryGirl.create(:user, name: 'admin')
    e = FactoryGirl.create(:event, name: 'event', owner: u)
    r = FactoryGirl.create(:role, name: 'participant')
    pp = FactoryGirl.create(:pricing_period, name: 'first', start_date: start_date, end_date: end_date)
    ep = FactoryGirl.create(:event_price, price: event_price, pricing_period: pp, role: r, event: e)
    db = {}
    db["pricing_period"] = pp
    db["role"] = r
    db["event_price"] = ep
    db
  end
end
