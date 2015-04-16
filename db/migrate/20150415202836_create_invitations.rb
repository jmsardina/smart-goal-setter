class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :invitable_type
      t.integer :invitable_id
      t.string :status, default: "pending"

      t.timestamps null: false
    end
  end
end
