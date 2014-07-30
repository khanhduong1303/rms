class Service < ActiveRecord::Base
  belongs_to :service_category

  has_attached_file :icon_path, styles: {icon: '64x64#'}, default_url: '/images/fav.svg'
  validates_attachment :icon_path, size: {:in => 0..1.megabytes}, content_type: {:content_type => /^image\/(jpeg|png|gif|tiff)$/}

  has_attached_file :image_path, styles: {thumbnail: '320x240#'}, default_url: '/images/no-image-43.svg'
  validates_attachment :image_path, size: {:in => 0..3.megabytes}, content_type: {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
end

