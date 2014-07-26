class CreateFeedbackReplies < ActiveRecord::Migration
  def change
    create_table :feedback_replies do |t|
      t.text :content
      t.integer :feedback_id
      t.timestamps
    end
  end
end
