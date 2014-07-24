class Form < ActiveRecord::Base
  belongs_to :form_category

  has_attached_file :form_path
  validates_attachment :form_path, presence: true, content_type: { content_type: 'application/pdf' }, size: { :in => 0..6.megabytes }
  validates :title, presence: true
end

