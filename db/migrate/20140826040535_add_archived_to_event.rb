class AddArchivedToEvent < ActiveRecord::Migration
  def change
    add_column :events, :archived, :boolean, default: 0
  end
end
