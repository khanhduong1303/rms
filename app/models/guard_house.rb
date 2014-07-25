class GuardHouse < ActiveRecord::Base
  belongs_to :condo
  has_many :guard_house_images, dependent: :destroy

  has_attached_file :photo_path, styles: { thumbnail: '640x360#'}, default_url: '/images/no-image-169.svg'
  validates_attachment :photo_path, size: { :in => 0..3.megabytes }, content_type: { :content_type => /^image\/(svg|jpeg|png|gif|tiff)$/ }

  has_attached_file :map_path, styles: { thumbnail: '640x360#'}, default_url: '/images/no-image-169.svg'
  validates_attachment :map_path, size: { :in => 0..3.megabytes }, content_type: { :content_type => /^image\/(svg|jpeg|png|gif|tiff)$/ }
end

