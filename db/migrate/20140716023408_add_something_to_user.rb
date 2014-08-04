class AddSomethingToUser < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean ,default: false
    User.update_all(:active => true)
  end
end
