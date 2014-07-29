class CreateServiceAbouts < ActiveRecord::Migration
  def change
    create_table :service_abouts do |t|
      t.attachment :image_path
      t.text :description
      t.string :call_to_order
      t.string :email
      t.text :more_info
      t.integer :service_id

      t.timestamps
    end
  end
end
