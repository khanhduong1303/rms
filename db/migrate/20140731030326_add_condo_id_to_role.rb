class AddCondoIdToRole < ActiveRecord::Migration
  def change
  		 add_column :roles, :condo_id, :integer
  		 Role.update_all(:condo_id => 1)
  end
end
