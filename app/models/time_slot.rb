class TimeSlot < ActiveRecord::Base
	belongs_to :facility
	validates :slot_start, presence: true
	validates :slot_end, presence: true
end
