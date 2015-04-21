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


  def percentage_activity_complete
    completed = ( sum_activity_occurences - sum_remaining_activity_occurences)
    (sum_activity_occurences > 0) ? ((completed.to_f / sum_activity_occurences)*100).round(0) : 0
  end

  def sum_activity_occurences
    if self.activities.any?
      array = []
      self.activities.map do |activity|
        array << activity.number_occurences
      end
      array.inject(:+)
    else
        0
    end
  end

  def sum_remaining_activity_occurences
    if self.activities.any?
      array =[]
      self.activities.each do |activity|
        array << activity.occurences
      end
      array.inject(:+)
    else
      0
    end
  end

  def percentage_complete
    activity_occurences = 0
    self.activities.each do |activity|
      activity_occurences += activity.number_occurences
    end
    (self.goal_points / activity_occurences.to_f) * 100
  end

  def maximum_points
    points = 0
    self.activities.each do |activity|
      points += activity.number_occurences
    end
  end

end
