class AddColumnRemovedToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :removed, :boolean, default: false
  end
end
