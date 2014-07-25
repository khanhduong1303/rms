class FeedbackCategory < ActiveRecord::Base
	  has_many :feedbacks
	  belongs_to :condo
end
