class AddCheerCountToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :cheer_count, :integer, default: 0
  end
end
