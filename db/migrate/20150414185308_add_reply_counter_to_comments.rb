class AddReplyCounterToComments < ActiveRecord::Migration
  def change
    add_column :comments, :reply_counter, :integer, default: 0
  end
end
