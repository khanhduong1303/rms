class AddDescripeToPermission < ActiveRecord::Migration
  def change
  	 add_column :permissions, :describe, :text 
  end
end
