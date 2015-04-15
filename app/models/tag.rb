class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
	# has_many :goal_tags
	# has_many :goals, through: :goal_tags

end
