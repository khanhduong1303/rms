class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :time_slot
  has_one :facility, through: :time_slot
end
