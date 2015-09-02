FactoryGirl.define do
  factory :pricing_period do
    name "Period"
    start_date "2015-09-30 23:27:52"
    end_date "2015-12-31 23:27:52"
    event { Event.first }
  end
end
