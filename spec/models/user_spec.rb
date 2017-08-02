require 'rails_helper'

describe User do
  describe "#calculate_today" do

    let(:user) { FactoryGirl.create(:user) }

    it "should be within 1 day of UTC today" do
      expect(user.today).to be_within(1).of(Time.now.utc.to_date)
    end

  end

  describe "#retrieve_upcoming_posts" do

    let(:n_weeks) {2}
    let!(:epoch_now) {Time.zone.now.to_i}
    let!(:user) { FactoryGirl.create(:user) }
    let!(:account) { FactoryGirl.create(:account, user: user) }
    let!(:past_post) { FactoryGirl.create(:post, distribution_time: Time.zone.now - 1.day, distribution: FactoryGirl.create(:distribution, account: account)) }
    let!(:future_post) { FactoryGirl.create(:post, distribution_time: Time.zone.now + 1.week, distribution: FactoryGirl.create(:distribution, account: account)) }
    let!(:far_future_post) { FactoryGirl.create(:post, distribution_time: Time.zone.now + 1.year, distribution: FactoryGirl.create(:distribution, account: account)) }
    let!(:distribution_times) {user.upcoming_posts(n_weeks).pluck(:distribution_time)}

    it "should contain posts ordered by ascending distribution time" do
      expect(distribution_times).to eq(distribution_times.sort)
    end

    it "should not contain posts from the past" do
      expect(distribution_times.min.to_i).to be >= epoch_now
    end

    it "should not contain posts more than n_weeks in the future" do
      expect(distribution_times.max.to_i).to be <= epoch_now + n_weeks.weeks
    end

  end

end
