FactoryGirl.define do
  sequence(:number) { |i| i + 1 }

  factory :day do
    number
    event { Event.first }
  end
end
