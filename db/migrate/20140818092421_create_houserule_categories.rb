class CreateHouseruleCategories < ActiveRecord::Migration
  def change
    create_table :houserule_categories do |t|
      t.integer :condo_id
      t.string :name
      t.timestamps
    end
  end
end
