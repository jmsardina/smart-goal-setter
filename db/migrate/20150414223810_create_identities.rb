class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.belongs_to :user, index: true
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
    add_foreign_key :identities, :users
  end
end
