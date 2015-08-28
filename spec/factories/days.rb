FactoryGirl.define do
  sequence(:number) { |i| i + 1 }

  factory :day do
    number
  end
end
