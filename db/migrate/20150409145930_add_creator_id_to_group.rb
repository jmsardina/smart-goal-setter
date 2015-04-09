class AddCreatorIdToGroup < ActiveRecord::Migration
  def change
  	add_column :groups, :creator_id, :integer,  {:foreign_key=>:user_id}
  end
end
