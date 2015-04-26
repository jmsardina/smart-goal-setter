class Activity < ActiveRecord::Base
  attr_accessor :number_occurences
	belongs_to :goal
	# has_many :comments, as: :commentable, dependent: :destroy
	delegate :user, to: :goal
  validates :description, presence: true
  validates :frequency, :period, :deadline, presence: true

  before_save :default_values
  def default_values
    self.remaining_for_period ||= self.frequency
  end

  def complete?
    self.status == true
  end

  def activity_timeline
  	(self.deadline - self.created_at.to_date).to_i
  end

  def days_in_period
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

  def periods_in_timeline #returns the number of periods within the activity timeline
  	if days_in_period
      activity_timeline / days_in_period
    end
  end

  def number_occurences #returns the total number of times an activity will occur
    self.frequency * periods_in_timeline
  end

  def cycle_start_date #returns the first date of the cycle
    (self.upcoming_deadline - 1.send(self.period))
  end

  def valid_cycle_dates #returns a range (period start date..period end date)
    self.cycle_start_date..self.upcoming_deadline
  end

  def needs_counter_reset? #returns true if activity has not been completed this cycle.
    self.updated_at < cycle_start_date
  end

  def restart_activity_counter #reset remaining_for_period to frequency at start of new period
    if self.needs_counter_reset?
      self.remaining_for_period = self.frequency
      self.save
    end
  end

  def upcoming_due_dates #returns an array of the periodic activity due dates
    start_date = self.created_at.to_date
    upcoming = []

    while start_date < self.deadline
      if (start_date + 1.send(self.period)) <= self.deadline
        new_due_date = start_date + 1.send(self.period)
        upcoming << new_due_date
        start_date = new_due_date
      else
        upcoming << self.deadline unless upcoming.include?(self.deadline)
        start_date = self.deadline
      end
    end
    upcoming.delete(upcoming[0]) if Time.now.to_date >= upcoming[0]
    upcoming
  end

  def add_point_and_decrement_occurences
    @user = self.user
    if self.complete?
      unless self.remaining_for_period == 0
        self.decrement!(:occurences)
        self.increment!(:activity_points)
        self.decrement!(:remaining_for_period)
        self.goal.increment!(:goal_points)
        @user.increment!(:points)
        self.status = false
      end
      self.save
    end
  end
end
