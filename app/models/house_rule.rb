class HouseRule < ActiveRecord::Base
  belongs_to :condo

  validates :title, :content, presence: true
  validates :title, uniqueness: true
end

