FactoryGirl.define do
  factory :account do
    username         { Faker::Internet.user_name }
    avatar           { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images','1.png'), 'image/jpg') }
    user
    provider
  end
end