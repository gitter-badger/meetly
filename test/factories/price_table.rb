FactoryGirl.define do
  factory :price_table do
    sequence(:name) {|i| "Table #{i+1}"}
    sequence(:days) {|i| 5*i+99}
    sequence(:day1) {|i| 20 + 2*i}
    sequence(:day2) {|i| 20 + 2*i}
    day3 60
    night 10
    dinner 15
  end
end