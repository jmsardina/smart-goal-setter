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
  	when "daily"
  		time = 1
  	when "weekly"
  		time = 7
  	when "monthly"
  		time = 30
  	when "yearly"
  		time = 365
  	end
  	time
  end

  # define how many time an activity is going to occur within the range
  def periods_in_range
  	activity_range / convert_period_to_time
  end

  def number_occurences
  	self.frequency * time_unit
  end

end

