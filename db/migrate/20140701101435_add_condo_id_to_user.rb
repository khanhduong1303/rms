class AddCondoIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :condo_id, :integer
  end
end

