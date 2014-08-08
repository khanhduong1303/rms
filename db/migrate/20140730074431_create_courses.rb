class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :instructor
      t.float :price
      t.string :phone
      t.string :email
      t.attachment :image_path
      t.text :more_info
      t.integer :condo_id

      t.timestamps
    end
  end
end

