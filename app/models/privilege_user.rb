class PrivilegeUser < ActiveRecord::Base
  belongs_to :privilege
  belongs_to :user
end

