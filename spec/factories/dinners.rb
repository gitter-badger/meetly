FactoryGirl.define do
  factory :dinner do
    sequence(:number) { |i| i + 1 }
  end
end
