class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :per_name
      t.timestamps
    end
  end
end
