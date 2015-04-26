class AddDeadlineToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :deadline, :date
  end
end
