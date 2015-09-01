FactoryGirl.define do
  factory :service do
    sequence(:name) { |i| "Service#{i + 1}" }
    event { Event.first }
    service_group { ServiceGroup.first }
  end
end
