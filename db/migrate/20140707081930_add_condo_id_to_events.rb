class AddCondoIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :condo_id, :integer
  end
end
