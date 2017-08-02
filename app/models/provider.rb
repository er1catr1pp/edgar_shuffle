class Provider < ApplicationRecord

  # image attachment via carrierwave
  mount_uploader :icon, IconUploader

  has_many  :accounts
  has_many  :users, :through => :accounts

  validates  :name, :presence => true
  
  # carrierwave validator for file presence
  validates_presence_of :icon

end