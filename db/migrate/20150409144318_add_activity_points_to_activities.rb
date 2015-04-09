class AddActivityPointsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :activity_points, :integer, default: 0
  end
end
