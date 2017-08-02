FactoryGirl.define do
  factory :category do
    name                  { Faker::Commerce.department }
    color                 { Faker::Color.hex_color }
    is_shuffled           { Faker::Boolean.boolean }
    last_unshuffled_time  { Faker::Time.backward(5, :all) }
    user
  end
end