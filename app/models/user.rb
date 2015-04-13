class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :feeds
  has_many :goals
  has_many :comments

  has_many :groups, foreign_key: :creator_id

  #as member
  has_many :user_groups, foreign_key: :member_id

  has_many :goals
  has_many :activities, through: :goals
  has_many :comments
  # has_many :groups, through: :user_groups

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "../assets   /missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def self.search(query)
    results = where("email like ?", "%#{query}%")
  end

  # def upcoming_activities
  #   activities_hash = {}

  #   self.activities.each do |activity|
  #     (activities_hash[activity.description] = {activity.upcoming_due_dates.first => activity.remaining_for_period})
  #   end
  #   [activities_hash]
  # end

  # def due_this_week

  # end
end
