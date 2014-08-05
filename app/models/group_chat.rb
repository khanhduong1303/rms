class GroupChat < ActiveRecord::Base
  belongs_to :user
  belongs_to :group_chat_list
end
