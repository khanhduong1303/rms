class CreatePrivilegeUsers < ActiveRecord::Migration
  def change
    create_table :privilege_users do |t|
      t.integer :privilege_id
      t.integer :user_id

      t.timestamps
    end
  end
end
