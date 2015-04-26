class AddMeasureAndConsequenceToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :measure, :string
    add_column :goals, :consequence, :string
  end
end
