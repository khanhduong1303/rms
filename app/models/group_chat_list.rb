class GroupChatList < ActiveRecord::Base
  has_many :group_chats, dependent: :destroy
  has_many :group_chat_members, dependent: :destroy
end
