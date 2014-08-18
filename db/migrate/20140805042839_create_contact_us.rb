class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :message, null: false
      t.string :role, null: false

      t.timestamps
    end
  end
end

