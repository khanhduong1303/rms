class Facility < ActiveRecord::Base
	belongs_to :facility_category
	has_many :time_slots
	has_many :facility_statuses
	has_attached_file :image, :styles => {  :default => "140x140>"}, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
validates_attachment :image,
    :size => { :in => 0..3.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }
end
