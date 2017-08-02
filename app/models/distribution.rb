class Distribution < ApplicationRecord

  belongs_to  :account
  belongs_to  :content

  has_many  :posts

end