class CreateCheers < ActiveRecord::Migration
  def change
    create_table :cheers do |t|
      t.belongs_to :user, index: true
      t.string :cheerable_type
      t.integer :cheerable_id

      t.timestamps null: false
    end
    add_foreign_key :cheers, :users
  end
end
