class CreateGuardHouseImages < ActiveRecord::Migration
  def change
    create_table :guard_house_images do |t|
      t.string :name
      t.attachment :image_path
      t.integer :guard_house_id

      t.timestamps
    end
  end
end
