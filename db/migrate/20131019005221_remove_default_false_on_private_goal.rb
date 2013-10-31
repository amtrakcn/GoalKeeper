class RemoveDefaultFalseOnPrivateGoal < ActiveRecord::Migration
  def change
    remove_column :goals, :private_goal
    add_column :goals, :private_goal, :boolean, :default => 0
  end
end
