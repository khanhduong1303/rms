class Feedback < ActiveRecord::Base
	has_one :feedback_reply ,dependent: :destroy
	belongs_to :feedback_category
	belongs_to :user
	validates :user_id, presence: true
	validates :feedback_category_id, presence: true
end
