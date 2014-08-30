class Privilege < ActiveRecord::Base
  belongs_to :user
  has_many :privilege_users, dependent: :destroy

  has_attached_file :image_path, styles: {large: '300x250#',  thumb: '150x150#', small: '100x100#'}, default_url: '/images/no-image.jpg'
  validates_attachment_content_type :image_path, :content_type => /\Aimage\/.*\Z/
end

