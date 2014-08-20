class Feedback < ActiveRecord::Base
	has_one :feedback_reply ,dependent: :destroy
	belongs_to :feedback_category
	belongs_to :user
	validates :user_id, presence: true
	validates :feedback_category_id, presence: true
  has_attached_file :image, :styles => {:thump => "200x200>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment :image,
                       :size => {:in => 0..3.megabytes},
                       :content_type => {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
end
