class CreateFriendLists < ActiveRecord::Migration
  def change
    create_table :friend_lists do |t|
      t.integer :request_user
      t.integer :confirm_user
      t.boolean :is_confirm

      t.timestamps
    end
  end
end
