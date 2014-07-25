class Feedback < ActiveRecord::Base
	has_one :feedback_reply ,dependent: :destroy
	belongs_to :feedback_category
	belongs_to :user
end
