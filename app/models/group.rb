class Group < ActiveRecord::Base

  belongs_to :creator, class_name: "User"
  has_many :user_groups
  has_many :members, through: :user_groups


end
