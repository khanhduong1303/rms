class Bulletin < ActiveRecord::Base
  # References
  belongs_to :condo

  # Validates
  validates :title, :date, :content, :send_notify, :condo_id, presence: true
  validates :condo_id, numericality: true
end
