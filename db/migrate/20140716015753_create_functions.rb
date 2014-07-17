class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.string :alias
      t.integer :permission_id
      t.string :name
      t.timestamps
    end
  end
end
