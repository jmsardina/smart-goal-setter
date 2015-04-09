class Activity < ActiveRecord::Base
  attr_accessor :number_occurences
	belongs_to :goal
	# has_many :comments, as: :commentable, dependent: :destroy
	delegate :user, to: :goal

  def complete?
    self.status == true
  end

  def incomplete?
    status == false
  end

  def activity_range
  	# we want to calculate the number of days between the start of
  	# an activity (created_at) and the en of the goal (due_date)
  	(self.goal.due_date - self.created_at.to_date).to_i
  end

  # find out what is the activity period (daily, weekly, monthly)
  # converting periods in days (daily = 7)
  # checking the frequency, then multiplying the frequency by the period (frequency= 3, period= weekly) to get the
  # of times the activity must be completed

  # converting the period column to a integer day ( weekly = 7, monthly = 30)
  def convert_period_to_time
  	case self.period
  	when "day"
  		time = 1
  	when "week"
  		time = 7
  	when "month"
  		time = 30
  	when "year"
  		time = 365
  	end
  	time
  end

  # define how many time an activity is going to occur within the range
  def periods_in_range
  	activity_range / convert_period_to_time
  end

  def number_occurences
  	self.frequency * periods_in_range
  end

  def upcoming_due_dates
    initial_date = self.created_at.to_date
    upcoming = []

    while initial_date < self.goal.due_date
      if (self.goal.due_date - initial_date) >= periods_in_range
        new_date = initial_date + 1.send(self.period)
        upcoming << new_date
        initial_date = new_date
      end
    end
    upcoming.delete(upcoming[0]) if Time.now.to_date > upcoming[0]
    upcoming
  end

  def previous_points

  end

  def completed_this_period
    self.points_for_activity - self.previous_points
  end

  def activities_left_for_period
    self.frequency - self.completed_this_period
  end

  def upcoming_activities
  
  end

  def add_point_and_decrement_occurences
    @user = self.user
    if self.complete?
      self.decrement!(:occurences)
      self.increment!(:activity_points)
      @user.increment!(:points)
    end
  end

  # def points_for_activity
  #   self.number_occurences -= 1 if self.complete?
  # end
end

