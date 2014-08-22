class Condo < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :feedback_categories
  has_many :feedbacks , through: :feedback_categories
  has_many :facility_categories, dependent: :destroy
  has_many :facilities, through: :facility_categories
  has_many :house_rules, dependent: :destroy
  has_many :form_categories, dependent: :destroy
  has_many :forms, through: :form_categories
  has_many :condo_images, dependent: :destroy
  has_many :guard_houses, dependent: :destroy
  has_many :guard_house_images, through: :guard_houses
  has_many :service_categories, dependent: :destroy
  has_many :services, through: :service_category
  has_many :courses, dependent: :destroy
  has_many :bulletins ,dependent: :destroy
  has_many :events , through: :users
  has_many :houserule_categories , dependent: :destroy
  has_many :house_rules , through: :houserule_categories
end

