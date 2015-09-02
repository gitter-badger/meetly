FactoryGirl.define do
  factory :event_price do
    price 10
    event { Event.first }
    role
    pricing_period
  end
end
