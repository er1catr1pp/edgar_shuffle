# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  :first_name => 'Edgar', :last_name => 'Octopus', :time_zone => 'Pacific Time (US & Canada)'
])

categories = Category.create([
  {:name => "Inspirational/Funny", :color => "#295C1C", :user => users.first},
  {:name => "My Blog Posts", :color => "#4780C6", :user => users.first},
  {:name => "My Podcast Episodes", :color => "#5C9E50", :user => users.first},
  {:name => "Promotional", :color => "#CE8D17", :user => users.first},
  {:name => "Questions", :color => "#A98B42", :user => users.first},
  {:name => "Tips", :color => "#C36D5B", :user => users.first},
  {:name => "Use Once", :color => "#601964", :user => users.first}
])

providers = Provider.create([
  {:name => 'Facebook', :icon => File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'provider', 'facebook.png'))},
  {:name => 'Linkedin', :icon => File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'provider', 'linkedin.png'))},
  {:name => 'Twitter', :icon => File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'provider', 'twitter.png'))}
])

accounts = Account.create([
  {:username => "Edgar", :avatar => File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'account', 'facebook_edgar.png')), :user => users.first, :provider => providers.first},
  {:username => "@edgar", :avatar => File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'account', 'twitter_edgar.png')), :user => users.first, :provider => providers.last}
])

# make a random set of schedules that has an average 
# of three timeslots per day and assign it to one or both
# available accounts
schedules = []
schedule_assignments = []
(7 * 3).times do |i|

  # create the schedule
  schedule = Schedule.create(:send_on => (0..6).to_a.sample, :send_at => (0..(24 * 60 - 1)).to_a.sample.minutes.to_i, :category => categories.sample)
  schedules << schedule

  # for clarity, just use twitter and create the associated schedule_assignment
  schedule_assignments << ScheduleAssignment.create(:schedule => schedule, :account => accounts.last)

end

podcast_image = File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'content', 'podcast.png'))
tentacle_image = File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'content', 'tentacle.png'))
sunglasses_image = File.open(File.join(Rails.root, 'app', 'assets', 'images', 'seed', 'content', 'sunglasses.png'))

contents = Content.create([
  {:text => "Cephalo-Podcast Episode 1", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 2", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 3", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 4", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 5", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 6", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 7", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 8", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 9", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 10", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 11", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 12", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 13", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 14", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 15", :image => podcast_image, :category => categories[2]},
  {:text => "Cephalo-Podcast Episode 16", :image => podcast_image, :category => categories[2]},
  {:text => "Does Edgar hug with all of his arms?", :image => tentacle_image, :category => categories[4]},
  {:text => "If you high five Edgar, does your hand stick to his tentacle?", :category => categories[4]},
  {:text => "Does Edgar wear sunglasses when he is close to sea stars?", :image => sunglasses_image, :category => categories[4]},
  {:text => "How to write great code with only two arms - Tip 1", :category => categories[5]},
  {:text => "How to write great code with only two arms - Tip 2", :category => categories[5]},
  {:text => "How to write great code with only two arms - Tip 3", :category => categories[5]},
  {:text => "How to write great code with only two arms - Tip 4", :category => categories[5]},
  {:text => "How to write great code with only two arms - Tip 5", :category => categories[5]},
  {:text => "How to write great code with only two arms - Tip 6", :category => categories[5]},
  {:text => "How to write great code with only two arms - Tip 7", :category => categories[5]},
  {:text => "How to write great code with only two arms - Tip 8", :category => categories[5]}
])

# decide through which accounts 
# each piece of content can be distributed
distributions = []
contents.each_with_index do |content, i|
  
  if i < 16
    # both accounts for the podcast episodes
    accounts.each do |account|
      distributions << Distribution.create(:account => account, :content => content)
    end
  elsif i < 19
    # twitter for questions
    distributions << Distribution.create(:account => accounts.last, :content => content)
  else
    # facebook for tips
    distributions << Distribution.create(:account => accounts.first, :content => content)
  end

end

# populate the queue
Category.all.each do |category|
  category.repopulate_queue
end
