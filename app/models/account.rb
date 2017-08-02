class Account < ApplicationRecord

  # image attachment via carrierwave
  mount_uploader :avatar, AvatarUploader

  belongs_to  :provider
  belongs_to  :user

  has_many    :distributions
  has_many    :contents, :through => :distributions
  has_many    :schedule_assignments
  has_many    :schedules, :through => :schedule_assignments

  validates :username, :presence => true

end