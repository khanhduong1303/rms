class CreateFormCategories < ActiveRecord::Migration
  def change
    create_table :form_categories do |t|
      t.string :name, null: false
      t.integer :condo_id, null: false

      t.timestamps
    end
  end
end

