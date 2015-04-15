class AddCheersToComments < ActiveRecord::Migration
  def change
    add_column :comments, :cheer_count, :integer, default: 0
  end
end
