class AddGoalPointsToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :goal_points, :integer, default: 0
  end
end
