class Form < ActiveRecord::Base
  belongs_to :form_category

  @@doc_types = {
      :image => ['image/jpg','image/jpeg','image/pjpeg','image/png','image/x-png','image/gif'],
      :pdf => ['application/pdf'],
      :word => ['application/msword','applicationvnd.ms-word','applicaiton/vnd.openxmlformats-officedocument.wordprocessingm1.document'],
      :excel => ['application/msexcel','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'],
      :powerpoint => ['application/mspowerpoint','application/vnd.ms-powerpoint','application/vnd.openxmlformats-officedocument.presentationml.presentation'],
      # :text => ['text/plain']

  }
  has_attached_file :form_path
  validates_attachment :form_path, presence: true, :content_type => { :content_type => ['application/pdf', 'application/msexcel', 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/msword' ,'applicationvnd.ms-word', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'] }, size: {:in => 0..6.megabytes}
  # content_type: {content_type: ['application/pdf']}
  validates :title, presence: true
end

