FactoryGirl.define do
  factory :service do
    sequence(:name) { |i| "Service#{i + 1}" }
    event { Event.first }
    price 10
    service_group { ServiceGroup.first }
  end
end
