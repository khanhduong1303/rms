class EventImage < ActiveRecord::Base
  belongs_to :event
  has_attached_file :image, styles: {large: '250x250#', medium: '200x200#', thumb: '150x150#', small: '100x100#'}, default_url: '/images/no-image.jpg'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

