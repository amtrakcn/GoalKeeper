class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, :null => false
      t.text :details
      t.boolean :private_goal
      t.integer :user_id

      t.timestamps
    end

    add_index :goals, :user_id
  end
end
