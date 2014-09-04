class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.attachment :icon_path
      t.attachment :image_path
      t.attachment :our_menu
      t.text :description
      t.string :call_to_order
      t.string :address
      t.string :email
      t.string :web_page
      t.string :order_hours
      t.text :term
      t.integer :service_category_id
      t.integer :user_id 
      t.timestamps
    end
  end
end

