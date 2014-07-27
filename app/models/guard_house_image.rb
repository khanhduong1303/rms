class GuardHouseImage < ActiveRecord::Base
  belongs_to :guard_house

  has_attached_file :image_path, styles: {thumbnail: '100x100#'}, default_url: '/images/no-image-43.svg'
  validates_attachment :image_path, size: {:in => 0..3.megabytes}, content_type: {:content_type => /^image\/(svg|jpeg|png|gif|tiff)$/}
end

