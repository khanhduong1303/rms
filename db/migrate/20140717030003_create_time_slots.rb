class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :facility_id
      t.time :slot_start
      t.time :slot_end
      t.boolean :peak

      t.timestamps
    end
  end
end
