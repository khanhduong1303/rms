class Bulletin < ActiveRecord::Base
  # References
  belongs_to :condo

  # Validates
  validates :title, :date, :content, presence: true
  validates :title, uniqueness: true
  validates :condo_id, numericality: true

  has_attached_file :image_path, styles: {thumb: '150X150#'}, default_url: '/images/no-image-11.svg'
  validates_attachment :image_path, size: {:in => 0..2.megabytes}, content_type: {:content_type => /^image\/(jpeg|png|gif|tiff)$/}


end

