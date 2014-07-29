class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.attachment :icon_path
      t.string :service_category_id
      t.string :integer

      t.timestamps
    end
  end
end
