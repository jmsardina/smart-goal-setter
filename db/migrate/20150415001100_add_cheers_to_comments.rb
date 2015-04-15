class AddCheersToComments < ActiveRecord::Migration
  def change
    add_column :comments, :cheers, :integer, default: 0
  end
end
