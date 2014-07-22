class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name, null: false
      t.float :booking_price, null: false
      t.float :deposit_price, null: false
      t.text :note
      t.string :image_path_file_name
      t.string :image_path_content_type
      t.integer :image_path_file_size
      t.datetime :image_path_updated_at
      t.boolean :active, default: true
      t.integer :facility_category_id, null: false

      t.timestamps
    end
  end
end

