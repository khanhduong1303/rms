class Condo < ActiveRecord::Base
  has_many :users
  has_many :facility_categories
  has_many :facilities , :through => :facility_categories
  has_many :house_rules, dependent: :destroy
end

