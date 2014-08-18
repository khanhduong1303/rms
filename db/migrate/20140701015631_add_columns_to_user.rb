class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :company, :string
    add_column :users, :postal_code, :string
    add_column :users, :enquiry, :text
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end

