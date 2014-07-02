class AddCondoIdToUser < ActiveRecord::Migration
  def change
  	add_column :users, :condo_id, :integer
  	remove_column :users, :condominium
  end
end
