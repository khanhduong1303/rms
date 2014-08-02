class CreateGroupChats < ActiveRecord::Migration
  def change
    create_table :group_chats do |t|
      t.string :message_content
      t.belongs_to :group_chat_list
      t.belongs_to :user
      t.timestamps
    end
  end
end
