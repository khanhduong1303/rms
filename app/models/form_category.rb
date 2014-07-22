class FormCategory < ActiveRecord::Base
  belongs_to :condo
  has_many :forms
end

