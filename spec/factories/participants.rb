FactoryGirl.define do
  factory :participant do
    first_name 'Todd'
    last_name 'White'
    age 60
    city 'New York'
    email 'todd@betelnet.pl'
    phone '664752055'
    role
    gender :man
    event { Event.first }
    days { [FactoryGirl.build(:day), FactoryGirl.build(:day), FactoryGirl.build(:day)] }
    status :created
  end
end
