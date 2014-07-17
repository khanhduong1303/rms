class FacilityCategory < ActiveRecord::Base
    belongs_to :condo
	has_many :facilities
end
