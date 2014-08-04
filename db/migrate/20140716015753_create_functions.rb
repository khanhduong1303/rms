class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t| 
      t.integer :permission_id
      t.string :action
      t.string :object
      t.timestamps
    end
  end
end
