class AddColumnRenderingToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :rendering, :boolean, default: true
  end
end
