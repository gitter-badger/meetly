class FactoryHelper
  def self.setup_database(start_date, end_date, event_price)
    u = FactoryGirl.create(:user, name: 'admin')
    e = FactoryGirl.create(:event, name: 'event', owner: u)
    r = FactoryGirl.create(:role, name: 'participant')
    pp = FactoryGirl.create(:pricing_period, name: 'first', start_date: start_date, end_date: end_date)
    ep = FactoryGirl.create(:event_price, price: event_price, pricing_period: pp, role: r, event: e)
    db = {}
    db[:pricing_period] = pp
    db[:role] = r
    db[:event_price] = ep
    db
  end

  def self.create_day_with_price(number, price, pricing_period, role)
    day = FactoryGirl.create(:day, number: number)
    day_price = FactoryGirl.create(:day_price, price: price, pricing_period: pricing_period, role: role, day: day)
    { day: day, day_price: day_price }
  end

  def self.create_services_with_group(group_name, services_count, price, role)
    sg = FactoryGirl.create(:service_group, name: group_name)
    single_name = group_name[0..-2]
    services = []
    (1..services_count).each do |i|
      service_pack = {}
      s = FactoryGirl.create(:service, name: single_name + i.to_s, service_group: sg)
      sp = FactoryGirl.create(:service_price, price: price, role: role, service: s)
      service_pack[:service] = s
      service_pack[:service_price] = sp
      services.push service_pack
    end
    services
  end
end
