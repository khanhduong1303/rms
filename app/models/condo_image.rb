class CondoImage < ActiveRecord::Base

	belongs_to :condo
  has_attached_file :image, :styles => { :big => "960x360#",
   :small => "150x150#"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

