class CreateMotivationalQuotes < ActiveRecord::Migration
  def change
    create_table :motivational_quotes do |t|
      t.string :content
      t.string :language

      t.timestamps null: false
    end
  end
end
