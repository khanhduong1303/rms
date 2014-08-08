class CourseUser < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  validates :course_id, :user_id, presence: true
  validates :course_id, :user_id, numericality: true
end

