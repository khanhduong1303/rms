class CreatePrivileges < ActiveRecord::Migration
  def change
    create_table :privileges do |t|
      t.string :location
      t.string :name
      t.float :price
      t.string :distance
      t.date :date_expiry
      t.attachment :image_path
      t.string :phone
      t.string :date_time_detail
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end

