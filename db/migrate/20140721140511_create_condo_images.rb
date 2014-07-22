class CreateCondoImages < ActiveRecord::Migration
  def change
    create_table :condo_images do |t|
      t.integer :condo_id
      t.timestamps
    end
  end
end
