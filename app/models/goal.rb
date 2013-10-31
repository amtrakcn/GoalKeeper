class Goal < ActiveRecord::Base
  attr_accessible :name, :user_id, :details, :private_goal

  validates :name, :user_id, :private_goal, :presence => true
  validates :private_goal, :inclusion => [true, false]

  belongs_to :user
end
