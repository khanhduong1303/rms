class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name
      t.integer :facility_category_id
      t.float :booking_price
      t.float :deposit_price
      t.text :note
      t.boolean :active
      
      t.timestamps
    end
  end
end
