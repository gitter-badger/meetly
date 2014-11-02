FactoryGirl.define do
  factory :participant do
    name "Todd"
    surname "White"
    age 60
    city "New York"
    email "todd@betelnet.pl"
    phone "664752055"
    days {[FactoryGirl.build(:day), FactoryGirl.build(:day), FactoryGirl.build(:day)]}
    association :role, factory: :role
    gender true
    end
end
