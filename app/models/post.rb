class Post < ApplicationRecord

  belongs_to  :distribution
  belongs_to  :schedule_assignment

  validates  :distribution_time, :presence => true

end