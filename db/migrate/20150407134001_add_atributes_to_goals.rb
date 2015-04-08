class AddAtributesToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :status, :boolean, default: false
    add_column :goals, :due_date, :date
    add_column :goals, :motivation, :string
    add_column :goals, :potential_barrier, :string
    add_column :goals, :coping_strategy, :string
    add_column :goals, :support, :string
  end
end
