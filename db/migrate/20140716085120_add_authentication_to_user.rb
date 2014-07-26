class AddAuthenticationToUser < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    User.update_all(:authentication_token => Devise.friendly_token)
  end
end
