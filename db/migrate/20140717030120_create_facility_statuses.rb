class CreateFacilityStatuses < ActiveRecord::Migration
  def change
    create_table :facility_statuses do |t|
      t.integer :facility_id
      t.date :close_from
      t.date :close_to
      t.text :reason
      t.timestamps
    end
  end
end
