FactoryGirl.define do
  factory :event do
    name "Test Event"
    start_date "2016-08-27 00:00:00"
    end_date "2016-08-30 00:00:00"
    price "99.00"
    owner { FactoryGirl.create(:user) }
  end
end
