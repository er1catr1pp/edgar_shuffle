FactoryGirl.define do
  factory :user do
    first_name        { Faker::Name.first_name }
    last_name         { Faker::Name.last_name }
    time_zone         { ActiveSupport::TimeZone::MAPPING.keys.sample }
  end
end