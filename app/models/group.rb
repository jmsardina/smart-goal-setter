class Group < ActiveRecord::Base

  belongs_to :creator, class_name: "User"
  has_many :user_groups
  has_many :members, through: :user_groups

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "../assets   /missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
