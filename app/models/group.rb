class Group < ActiveRecord::Base

  belongs_to :creator, class_name: "User"
  has_many :user_groups
  has_many :members, through: :user_groups

  def add_new_member(member)
    self.members << member
  end
	# has_many :user_groups
	# has_many :members, class_name: "User", foreign_key: :id
	# belongs_to :creator, class_name: "User", foreign_key: :creator_id
	# has_one :creator, class_name: "User", foreign_key: :id

end
