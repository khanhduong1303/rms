class CreateCondoImages < ActiveRecord::Migration
  def change
    create_table :condo_images do |t|
      t.string :image_path_file_name
      t.string :image_path_content_type
      t.integer :image_path_file_size
      t.datetime :image_path_created_at
      t.integer :condo_id

      t.timestamps
    end
  end
end

