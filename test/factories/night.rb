FactoryGirl.define do
  factory :night do
    sequence(:number) {|i| i+1}
  end
end