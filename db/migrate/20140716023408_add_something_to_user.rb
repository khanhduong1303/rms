class AddSomethingToUser < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean
    User.update_all(:active => true)
  end
end
