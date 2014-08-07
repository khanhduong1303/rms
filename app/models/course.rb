class Course < ActiveRecord::Base
  belongs_to :condo
  has_many :course_users, dependent: :destroy

  validates :name, :instructor, :price, :phone, :condo_id, presence: true
  validates :condo_id, numericality: true
end

