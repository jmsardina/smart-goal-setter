class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  # has_many :replies, class_name: "Comment", as: :commentable

  validates :content, presence: true
end
