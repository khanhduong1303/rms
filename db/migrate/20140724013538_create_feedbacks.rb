class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :title
      t.text :content
      t.boolean :archive ,default: false
      t.integer :user_id
      t.integer :feedback_category_id
      t.timestamps
    end
  end
end
