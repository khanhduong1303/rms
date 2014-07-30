class Course < ActiveRecord::Base
  belongs_to :condo
  has_many :course_users, dependent: :destroy
end

