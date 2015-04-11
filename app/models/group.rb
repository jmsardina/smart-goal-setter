class Group < ActiveRecord::Base

	has_many :user_groups
	has_many :users, through: :user_groups
	belongs_to :creator, class_name: "User", foreign_key: :creator_id

end
