class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.attachment :icon_path
      t.attachment :image_path
      t.text :description
      t.string :call_to_order
      t.string :email
      t.text :more_info
      t.integer :service_category_id

      t.timestamps
    end
  end
end

