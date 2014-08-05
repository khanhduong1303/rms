class AddIsStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_status, :boolean, default: true
  end
end
