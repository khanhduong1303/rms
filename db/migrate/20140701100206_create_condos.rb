class CreateCondos < ActiveRecord::Migration
  def change
    create_table :condos do |t|
      t.string :name
      t.string :image_project_path_file_name
      t.string :image_project_path_content_file
      t.integer :image_project_path_file_size
      t.datetime :image_project_path_created_at
      t.string :property_type
      t.string :developer
      t.string :tenure
      t.string :top_year
      t.integer :number_of_units
      t.text :description

      t.timestamps
    end
  end
end

