class Event < ActiveRecord::Base
  has_many :event_images, :dependent => :destroy
  has_many :join_events, :dependent => :destroy
  belongs_to :condo

  validates_presence_of :name, :date, :location, :organiser
end
