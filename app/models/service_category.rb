class ServiceCategory < ActiveRecord::Base
  belongs_to :condo
  has_many :services, dependent: :destroy
end

