class User < ApplicationRecord

  has_many  :categories
  has_many  :accounts
  has_many  :providers, :through => :accounts

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :time_zone, :inclusion => {:in => ActiveSupport::TimeZone::MAPPING.keys}

  def today
    Date.today.in_time_zone(time_zone).to_date
  end

  # pull the user's queue of upcoming posts for the next n_weeks
  def upcoming_posts(n_weeks = nil)

    query_string = "user_id = #{id} and (distribution_time >= '#{Time.zone.now.utc.to_s}')"
    if n_weeks
      utc_cutoff = local_end_of_day(n_weeks * 7).utc
      query_string += " and (distribution_time <= '#{utc_cutoff.to_s}')" if n_weeks
    end

    posts = Post.joins(
      :distribution => :account
    ).where(query_string).order("distribution_time")

  end

  private

    def local_end_of_day(n_days_from_now)
      Time.now.in_time_zone(time_zone).end_of_day + n_days_from_now.days
    end

end