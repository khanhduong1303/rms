class CreateHouseRules < ActiveRecord::Migration
  def change
    create_table :house_rules do |t|
      t.string :title
      t.text :content
      t.integer :houserule_category_id 

      t.timestamps
    end
  end
end
