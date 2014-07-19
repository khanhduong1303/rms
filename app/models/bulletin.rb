class Bulletin < ActiveRecord::Base
  # References
  belongs_to :user

  # Validates
  validates :title, :date, :content, :user_id, presence: true
  validates :user_id, numericality: true
end

