class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.integer :group_id
      t.integer :member_id

      t.timestamps null: false
    end
  end
end
