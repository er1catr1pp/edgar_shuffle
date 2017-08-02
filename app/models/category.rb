class Category < ApplicationRecord

  belongs_to  :user

  has_many  :contents
  has_many  :schedules

  validates :color, :presence => true
  validates :name, :presence => true

  before_save :set_last_unshuffled_time, if: ->(obj){ (not obj.is_shuffled) and obj.is_shuffled_changed? }
  before_save :repopulate_queue

  # re-populate the next n_weeks weeks of posts for this category
  # this handles shuffling, re-shuffling, and un-shuffling
  def repopulate_queue(n_weeks = 2)
    clear_queue
    populate_queue(n_weeks)
  end

  def n_contents
    contents.size.to_i
  end

  private

    def clear_queue
      user.upcoming_posts.joins(:distribution => :content).where(
        :contents => {:category_id => id}
      ).destroy_all
    end

    # schedule posts for the next n_weeks for this category
    def populate_queue(n_weeks)
      n_weeks.times do |i_week|
        schedules.sort_by{|s| s.distribution_time(i_week)}.each do |schedule|
          schedule.schedule_assignments.each do |schedule_assignment|

            content_distribution = next_content_distribution(schedule_assignment)

            Post.create(
              :distribution_time => schedule.distribution_time(i_week),
              :distribution_id => content_distribution.id,
              :schedule_assignment_id => schedule_assignment.id
            ) if content_distribution

          end
        end
      end
    end

    def contents_for_account(account)
      Content.joins(:distributions).where(
        :distributions => {:account_id => account.id},
        :contents => {:category_id => id}
      )
    end

    def next_content_distribution(schedule_assignment)
      
      distribution_account = schedule_assignment.account
      content = next_content_to_schedule(distribution_account)

      next_distribution = content ? content.distributions.where(:account_id => distribution_account).first : nil
    end

    def next_content_to_schedule(account)
      next_content = is_shuffled? ? next_shuffled_content_to_schedule(account) : next_unshuffled_content_to_schedule(account)
    end

    # the piece of content that's next-up for scheduling
    # based on random selection
    def next_shuffled_content_to_schedule(account)
      content = contents_for_account(account).sample
    end

    # the piece of content that's next-up for scheduling
    # based on last in, first out order
    def next_unshuffled_content_to_schedule(account)
        
      available_content = contents_for_account(account)
      last_post = last_post_scheduled_for_account(account)
      if last_post && (!last_unshuffled_time || (last_unshuffled_time < last_post.distribution_time))
        available_content = available_content.select{|c| c.created_at < last_post.distribution.content.created_at}
      end

      next_content = available_content.max_by{|c| c.created_at}

    end

    def last_post_scheduled_for_account(account)

      last_scheduled_post = Post.joins(:distribution, :schedule_assignment => :schedule).where(
        :schedule_assignments => {:account_id => account.id},
        :schedules => {:category_id => id}
      ).order("distribution_time desc").limit(1).first

    end

    def set_last_unshuffled_time
      self.last_unshuffled_time = Time.zone.now
    end


end