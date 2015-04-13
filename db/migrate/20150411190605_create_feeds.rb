class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.belongs_to :user, index: true
      t.string :action
      t.belongs_to :trackable, index: true
      t.string :trackable_type

      t.timestamps null: false
    end
    add_foreign_key :feeds, :users
    add_foreign_key :feeds, :trackables
  end
end
