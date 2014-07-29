class Service < ActiveRecord::Base
  belongs_to :service_category
  has_one :service_about, dependent: :destroy
end

