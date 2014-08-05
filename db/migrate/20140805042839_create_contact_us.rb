class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :message
      t.string :role

      t.timestamps
    end
  end
end
