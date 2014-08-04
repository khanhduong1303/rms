class Role < ActiveRecord::Base
  has_many :user_roles , dependent: :destroy
  has_many :users, :through => :user_roles
  has_many :per_roles , dependent: :destroy
  has_many :permissions, :through => :per_roles
  belongs_to :condo 


  validates :role_name, presence: true
end
