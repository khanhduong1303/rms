class CreateServiceCategories < ActiveRecord::Migration
  def change
    create_table :service_categories do |t|
      t.string :name
      t.attachment :icon_path
      t.integer :condo_id

      t.timestamps
    end
  end
end

