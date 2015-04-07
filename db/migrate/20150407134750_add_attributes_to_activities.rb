class AddAttributesToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :period, :string
    add_column :activities, :status, :boolean, default: 0
    add_column :activities, :barrier, :string
    add_column :activities, :facilitator, :string
  end
end
