class GroupChatMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :group_chat
end
