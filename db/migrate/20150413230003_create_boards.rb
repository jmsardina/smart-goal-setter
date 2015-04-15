class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.belongs_to :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :boards, :groups
  end
end
