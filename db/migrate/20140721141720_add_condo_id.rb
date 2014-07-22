class AddCondoId < ActiveRecord::Migration
  def change
  	add_column :condo_images , :condo_id , :integer
  end
end
