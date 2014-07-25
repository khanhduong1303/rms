class CreateGuardHouses < ActiveRecord::Migration
  def change
    create_table :guard_houses do |t|
      t.string :phone
      t.attachment :photo_path
      t.attachment :map_path
      t.integer :condo_id

      t.timestamps
    end
  end
end
