class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, :through => :user_roles
  has_many :per_roles
  has_many :permissions, :through => :per_roles


  validates :role_name, uniqueness: true
  validates :role_name, presence: true
end
