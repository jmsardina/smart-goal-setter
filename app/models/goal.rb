class Goal < ActiveRecord::Base

  belongs_to :user

  has_many :tags, as: :taggable
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :cheers, as: :cheerable, dependent: :destroy
  
  has_many :activities, dependent: :destroy
  validates :name, :description, :due_date, :motivation, :potential_barrier, :coping_strategy, :support, :measure, :consequence, presence: true

  accepts_nested_attributes_for :tags

  def complete?
    self.status == true
  end

  def days_left
    (self.due_date - Time.now.to_date).to_i
  end
end
