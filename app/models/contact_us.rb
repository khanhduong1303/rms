class ContactUs < ActiveRecord::Base
  validates :name, :email, :phone, :message, :role, presence: true
end

