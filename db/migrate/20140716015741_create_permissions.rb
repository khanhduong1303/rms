class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :per_name
      t.string :describe
      t.timestamps
    end
  end
end
