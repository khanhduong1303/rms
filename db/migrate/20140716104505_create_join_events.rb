class CreateJoinEvents < ActiveRecord::Migration
  def change
    create_table :join_events do |t|
      t.belongs_to :user
      t.belongs_to :event

      t.timestamps
    end
  end
end
