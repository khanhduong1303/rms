class CreateGroupChatLists < ActiveRecord::Migration
  def change
    create_table :group_chat_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
