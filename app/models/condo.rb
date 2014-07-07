class Condo < ActiveRecord::Base
  has_many :users
  has_many :bulletins
end
