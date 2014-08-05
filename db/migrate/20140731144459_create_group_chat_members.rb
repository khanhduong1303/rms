class CreateGroupChatMembers < ActiveRecord::Migration
  def change
    create_table :group_chat_members do |t|
      t.belongs_to :user
      t.belongs_to :group_chat_list

      t.timestamps
    end
  end
end
