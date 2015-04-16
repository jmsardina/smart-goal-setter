class AddInvitationIdToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :invitation_id, :integer
  end
end
