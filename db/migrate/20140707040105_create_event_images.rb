class CreateEventImages < ActiveRecord::Migration
  def change
    create_table :event_images do |t|
      t.text :description
      t.belongs_to :event
      t.timestamps
    end
  end
end
