class AddImageToFacility < ActiveRecord::Migration
  def self.up
    add_attachment :facilities, :image
  end

  def self.down
    remove_attachment :facilities, :image
  end
end
