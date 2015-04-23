class AddUpcomingDeadlineToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :upcoming_deadline, :date
  end
end
