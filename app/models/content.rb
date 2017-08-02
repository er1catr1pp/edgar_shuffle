class Content < ApplicationRecord

  # image attachment via carrierwave
  mount_uploader :image, ImageUploader

  belongs_to  :category

  has_many  :distributions
  has_many  :accounts, :through => :distributions

  validate :text_and_or_image_present

  private

    def text_and_or_image_present
      if text.blank? && image.file.nil?
        errors.add(:base, "Content must contain text, an image, or both")
      end
    end

end