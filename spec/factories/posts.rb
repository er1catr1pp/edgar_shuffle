FactoryGirl.define do
  factory :post do
    distribution_time    { [Faker::Time.forward(14, :all), Faker::Time.backward(50, :all)].sample }
    distribution
    schedule_assignment
  end
end