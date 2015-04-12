class Group < ActiveRecord::Base

	has_many :user_groups
	has_many :members, class_name: "User", foreign_key: :id
	belongs_to :creator, class_name: "User", foreign_key: :creator_id
	has_one :creator, class_name: "User", foreign_key: :id

end
