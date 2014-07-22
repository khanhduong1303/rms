class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :date_submit
      t.date :date_expiry
      t.date :date_book
      t.string :status
      t.integer :user_id
      t.integer :time_slot_id

      t.timestamps
    end
  end
end

