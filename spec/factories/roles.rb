FactoryGirl.define do
  factory :role do
    sequence(:name) { |i| "Role #{i + 1}" }
    price_table
  end
end
