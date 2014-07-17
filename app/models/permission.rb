class Permission < ActiveRecord::Base
has_many :per_roles
has_many :roles , :through => :per_roles
has_many :functions

  validates :per_name, uniqueness: true
  validates :per_name, presence: true
end
