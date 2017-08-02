FactoryGirl.define do
  factory :content do
    text         { Faker::Lorem.paragraph }
    image        { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images','2.png'), 'image/jpg') }
    category
  end
end