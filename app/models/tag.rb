class Tag < ActiveRecord::Base

	has_many :goal_tags
	has_many :goals, through: :goal_tags

end
