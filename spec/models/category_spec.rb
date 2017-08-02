require 'rails_helper'
require 'json'

describe Category do
  describe "#calculate_n_contents" do

    let!(:category_1) { FactoryGirl.create(:category) }
    let!(:category_2) { FactoryGirl.create(:category) }
    let!(:content_1) { FactoryGirl.create(:content, category: category_1)}
    let!(:content_2) { FactoryGirl.create(:content, category: category_1)}
    let!(:content_3) { FactoryGirl.create(:content, category: category_2)}

    it "should accurately count the number of contents associated with the category" do
      expect(category_1.n_contents).to eq(2)
    end

  end

  describe "#perform_repopulate_queue" do

    let!(:now) {Time.zone.now}
    let!(:user) { FactoryGirl.create(:user) }
    let!(:category) { FactoryGirl.create(:category) }
    let!(:account) { FactoryGirl.create(:account, user: user) }
    let!(:distribution) { FactoryGirl.create(:distribution, account: account, content: FactoryGirl.create(:content, category: category)) }
    let!(:post) { FactoryGirl.create(:post, distribution: distribution, distribution_time: Time.zone.now + 2.days) }
    let!(:schedule_assignment) { FactoryGirl.create(:schedule_assignment, schedule: FactoryGirl.create(:schedule, category: category)) }

    before do
      category.repopulate_queue
    end

    it "should populate the queue with all new posts" do
      min_created_at_in_queue = user.upcoming_posts.pluck(:created_at).max
      expect(min_created_at_in_queue).to be > now
    end

    it "should generate a non-empty queue" do
      n_category_posts = user.upcoming_posts.select{|post| post.distribution.content.category == category}.size
      expect(n_category_posts).to be > 0
    end

  end

end
