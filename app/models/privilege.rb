class Privilege < ActiveRecord::Base
  belongs_to :user
  has_many :privilege_users, dependent: :destroy
end

