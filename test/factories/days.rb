FactoryGirl.define do
  factory :day do
    sequence(:number) {|i| i+1}
  end
end