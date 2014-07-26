class CreateFeedbackCategories < ActiveRecord::Migration
  def change
    create_table :feedback_categories do |t|
      t.string :name
      t.integer :condo_id
      t.timestamps
    end
  end
end
