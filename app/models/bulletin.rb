class Bulletin < ActiveRecord::Base
  # References
  belongs_to :condo

  # Validates
  validates :title, :date, :content, :send_notify, :user_id, presence: true
  validates :user_id, numericality: true
end

