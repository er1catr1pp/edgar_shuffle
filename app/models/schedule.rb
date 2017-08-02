class Schedule < ApplicationRecord

  belongs_to  :category
  
  has_many    :schedule_assignments
  has_many    :schedules, :through => :schedule_assignments

  validates :send_at, :presence => true
  validates :send_on, :inclusion => {:in => (0..6).to_a}


  def distribution_time(n_weeks)
    epoch_t_distribution = send_on_date(n_weeks).to_time.to_i + send_at
    t_distribution = Time.at(epoch_t_distribution)
  end

  private

    # calculate the send_on date n_weeks from now
    def send_on_date(n_weeks)
      today = category.user.today
      send_on_date = today + n_weeks * 7 + (send_on - today.wday % 7)
      send_on_date += 7 if today.wday > send_on
      send_on_date
    end

end