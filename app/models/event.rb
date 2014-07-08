class Event < ActiveRecord::Base
  has_many :event_images, :dependent => :destroy
  belongs_to :condo
end
