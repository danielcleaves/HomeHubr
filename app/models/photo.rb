class Photo < ApplicationRecord
  belongs_to :house
  REQUIRED_WIDTH = 600
  REQUIRED_HEIGHT = 600

  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>', carousel: '460x345!', main: '600x600#' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  # validate :image_dimensions

  private

  def image_dimensions
    dimensions = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)

    errors.add(:image, "Width must be #{REQUIRED_WIDTH}px") unless dimensions.width == REQUIRED_WIDTH
    errors.add(:image, "Height must be #{REQUIRED_HEIGHT}px") unless dimensions.height == REQUIRED_HEIGHT
  end
end
