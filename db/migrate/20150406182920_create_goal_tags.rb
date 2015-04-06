class CreateGoalTags < ActiveRecord::Migration
  def change
    create_table :goal_tags do |t|
      t.belongs_to :goal, index: true
      t.belongs_to :tag, index: true

      t.timestamps null: false
    end
    add_foreign_key :goal_tags, :goals
    add_foreign_key :goal_tags, :tags
  end
end
