FactoryGirl.define do
  factory :schedule do
    send_on         (0..6).to_a.sample
    # number of seconds after midnight UTC from 0 to 86400 - 1
    send_at         (0..(24 * 60 * 60 - 1)).to_a.sample
    category
  end
end