class AddCheerCountToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :cheer_count, :integer, default: 0
  end
end
