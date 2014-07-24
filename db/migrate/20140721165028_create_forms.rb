class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :title, null: false
      t.attachment :form_path
      t.integer :form_category_id

      t.timestamps
    end
  end
end

