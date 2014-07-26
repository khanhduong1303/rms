class CreateFacilityCategories < ActiveRecord::Migration
  def change
    create_table :facility_categories do |t|
      t.string :name
      t.integer :condo_id

      t.timestamps
    end
  end
end
