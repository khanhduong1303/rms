class CreateFacilityStatuses < ActiveRecord::Migration
  def change
    create_table :facility_statuses do |t|
      t.string :image_path_file_name
      t.string :image_path_content_type
      t.integer :image_path_file_size
      t.datetime :image_path_updated_at
      t.date :close_from
      t.date :close_to
      t.text :reason
      t.integer :facility_id

      t.timestamps
    end
  end
end

