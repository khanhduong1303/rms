class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.boolean :archive, default: false

      t.timestamps
    end
  end
end

