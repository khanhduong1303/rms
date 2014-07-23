class Form < ActiveRecord::Base
  belongs_to :form_category

  has_attached_file :form_path
  validates_attachment :form_path, size: { :in => 0..3.megabytes }, content_type: { :content_type => /pdf$/ }
  validates :title, presence: true
end

