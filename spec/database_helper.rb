class DatabaseHelper

  def clear_database
    puts "Clearing DB..."
    Role.destroy_all
    Participant.destroy_all
    Day.destroy_all
    DayPrice.destroy_all
    Event.destroy_all
    EventPrice.destroy_all
    User.destroy_all
    Service.destroy_all
    ServicePrice.destroy_all
    ServiceGroup.destroy_all
    PricingPeriod.destroy_all
  end

  def setup_mandatory_tables
    u = User.create!(name: 'admin', email: 'admin@poczatek.org', password: 'pcztk2015')
    puts "User #{u.name} craeted!"
    e = Event.create!(name: 'Poczatek15/16', 
             start_date: Date.new(2015,12,29), end_date: Date.new(2015, 12,31), owner: u)
    puts "Event #{e.name} created!"

    pp = PricingPeriod.create!(name: 'turboprzedplata', event: e, start_date: Date.new(2015, 9, 1), end_date: Date.new(2015, 11, 11))
    puts "PricingPeriod #{pp.name} created!"

    r = Role.create!(
      name: 'Uczestnik',
      event_id: e.id
      )
    puts "Role #{r.name} created!"
  end





end
