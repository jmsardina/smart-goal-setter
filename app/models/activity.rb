class Activity < ActiveRecord::Base

	belongs_to :goal
	# has_many :comments, as: :commentable, dependent: :destroy
	delegate :user, to: :goal

  def complete?
    self.status == 1
  end

  def incomplete?
    status == 0
  end
end
