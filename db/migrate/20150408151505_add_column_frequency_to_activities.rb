class AddColumnFrequencyToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :frequency, :integer
  end
end
