class ScheduleAssignment < ApplicationRecord

  belongs_to  :account
  belongs_to  :schedule

  has_many  :posts

end