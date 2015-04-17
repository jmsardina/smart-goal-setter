class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :commentable, polymorphic: true
  has_many :replies, class_name: "Comment", as: :commentable, dependent: :destroy
  has_many :cheers, as: :cheerable, dependent: :destroy
  has_many :cheers, as: :cheerable, foreign_key: :reply_id

  validates :content, presence: true
end
