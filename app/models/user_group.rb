class UserGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :member, class_name: "User"
  # belongs_to :group
  # belongs_to :creator, class_name: "User"
  # belongs_to :user

end
