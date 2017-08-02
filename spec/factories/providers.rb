FactoryGirl.define do
  factory :provider do
    name         { ['Facebook','Twitter','Linkedin'].sample }
    icon         { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images','3.png'), 'image/jpg') }
  end
end