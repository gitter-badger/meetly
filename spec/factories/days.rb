FactoryGirl.define do
  factory :day do
    sequence(:number) { |i| i + rand(10) }
  end
end
