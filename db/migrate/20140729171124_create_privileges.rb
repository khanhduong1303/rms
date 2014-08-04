class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.string :location
      t.float :price
      t.string :distance
      t.date :date_expiry
      t.text :description
      t.attachment :image_path
      t.integer :user_id

      t.timestamps
    end
  end
end
