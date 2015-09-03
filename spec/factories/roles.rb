FactoryGirl.define do
  factory :role do
    sequence(:name) { |i| "Role #{i + 1}" }
    event_id { Event.first.id }
  end
end
