class AddCommentCounterToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :comment_counter, :integer, default: 0
  end
end
