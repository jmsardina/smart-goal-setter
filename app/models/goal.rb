class Goal < ActiveRecord::Base

  belongs_to :user

  has_many :tags, as: :taggable
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :cheers, as: :cheerable, dependent: :destroy
  
  has_many :activities, dependent: :destroy
  validates :name, :description, presence: true
  validates :due_date, presence: true

  accepts_nested_attributes_for :tags

  def complete?
    self.status == true
  end

  def incomplete?
    self.status == false
  end

  def days_left
    (self.due_date - Time.now.to_date).to_i
  end


  def total_activity_occurence
    occurence = 0
    self.activities.each do |activity|
      if activity.number_occurences
        occurence += activity.number_occurences
      end
    end
    occurence
  end

  def total_remaining_occurence
    remaining = 0
    self.activities.each do |activity|
      remaining += activity.occurences
    end
    remaining
  end


  def percentage_activity_occurence_complete
    ((1 - (self.total_remaining_occurence / self.total_activity_occurence.to_f)) * 100).round(1)
  end

end
