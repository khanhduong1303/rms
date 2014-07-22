class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :title, null: false
      t.string :form_path_file_name
      t.integer :form_path_file_size
      t.datetime :form_path_created_at
      t.integer :form_category_id

      t.timestamps
    end
  end
end

