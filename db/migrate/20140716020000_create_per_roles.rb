class CreatePerRoles < ActiveRecord::Migration
  def change
    create_table :per_roles do |t|
      t.integer :role_id
      t.integer :permission_id
      t.timestamps
    end
  end
end
