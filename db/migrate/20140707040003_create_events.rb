class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.time :event_start
      t.time :event_end
      t.string :location
      t.string :organiser
      t.text :description

      t.timestamps
    end
  end
end
