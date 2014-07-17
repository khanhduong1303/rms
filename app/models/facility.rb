class Facility < ActiveRecord::Base
	belongs_to :facility_category
	has_many :time_slots
	has_many :facility_statuses
end
