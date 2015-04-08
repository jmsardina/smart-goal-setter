class AddColumnOccurencesToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :occurences, :integer, default: 0
  end
end
