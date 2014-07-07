class AddImageToEventImages < ActiveRecord::Migration
  def self.up
    add_attachment :event_images, :image
  end

  def self.down
    remove_attachment :event_images, :image
  end
end
