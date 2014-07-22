class HouseRule < ActiveRecord::Base
  belongs_to :condo

  validates :title, :content, presence: true
end

