class Activity < ActiveRecord::Base

	belongs_to :goal
	# has_many :comments, as: :commentable, dependent: :destroy
	delegate :user, to: :goal

end
