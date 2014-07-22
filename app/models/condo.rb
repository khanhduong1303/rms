class Condo < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :facility_categories, dependent: :destroy
  has_many :facilities , through: :facility_categories
  has_many :house_rules, dependent: :destroy
  has_many :form_categories, dependent: :destroy
  has_many :forms, through: :form_categories
  has_many :condo_images, dependent: :destroy
end

