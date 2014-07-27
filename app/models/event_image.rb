class EventImage < ActiveRecord::Base
  belongs_to :event
  has_attached_file :image, styles: {large: '300x250#',  thumb: '150x150#'}, default_url: '/images/no-image.jpg'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  #medium: '200x200#',, small: '100x100#'
end

