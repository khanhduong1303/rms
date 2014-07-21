class FacilityStatus < ActiveRecord::Base
  belongs_to :facility

  has_attached_file :image_path, styles: { thumbnail: '320x240#' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image_path, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image_path, size: { :in => 0..3.megabytes }, content_type: { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  validates :close_from, :close_to, :facility_id, presence: true
end

