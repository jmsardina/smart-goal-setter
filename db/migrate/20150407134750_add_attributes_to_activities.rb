class AddAttributesToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :period, :string
    add_column :activities, :status, :boolean, default: false
    add_column :activities, :barrier, :string
    add_column :activities, :facilitator, :string
  end
end
