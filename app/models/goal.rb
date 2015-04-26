class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy

  has_many :tags, as: :taggable
  accepts_nested_attributes_for :tags
  
  validates :name, :description, :due_date, :motivation, :potential_barrier, :coping_strategy, :support, :measure, :consequence, presence: true


  def complete?
    self.status == true
  end

  def days_left
    (self.due_date - Time.now.to_date).to_i
  end
end
