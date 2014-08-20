class Course < ActiveRecord::Base
  belongs_to :condo
  has_many :course_users, dependent: :destroy

  validates :name, :instructor, :price, :phone, :condo_id, presence: true
  validates :condo_id, numericality: true

  has_attached_file :image_path, styles: {large: '300x200#',  thumb: '100x100#'}, default_url: '/images/no-image.jpg'
  validates_attachment_content_type :image_path, :content_type => /\Aimage\/.*\Z/
end

