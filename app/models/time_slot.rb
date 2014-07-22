class TimeSlot < ActiveRecord::Base
	belongs_to :facility
  has_one :booking
end
