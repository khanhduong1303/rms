class CreateIndividualChats < ActiveRecord::Migration
  def change
    create_table :individual_chats do |t|
      t.integer :sending_user
      t.integer :receiving_user
      t.string :message_content

      t.timestamps
    end
  end
end
