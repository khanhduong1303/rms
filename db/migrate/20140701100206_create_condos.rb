class CreateCondos < ActiveRecord::Migration
  def change
    create_table :condos do |t|
      t.string :name
       t.string :property_type
        t.string :developer
       t.string :tenure
       t.string :top_year
       t.integer :num_of_units
        t.text :description
      t.timestamps
    end
  end
end
