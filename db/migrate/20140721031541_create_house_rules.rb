class CreateHouseRules < ActiveRecord::Migration
  def change
    create_table :house_rules do |t|
      t.string :title
      t.text :content
      t.integer :condo_id

      t.timestamps
    end
  end
end
