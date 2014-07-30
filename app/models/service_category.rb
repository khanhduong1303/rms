class ServiceCategory < ActiveRecord::Base
  belongs_to :condo
  has_many :services, dependent: :destroy

  has_attached_file :icon_path, styles: {icon: '64x64#'}, default_url: '/images/fav.svg'
  validates_attachment :icon_path, size: {:in => 0..1.megabytes}, content_type: {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
end

