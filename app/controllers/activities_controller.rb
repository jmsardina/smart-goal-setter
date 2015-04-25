class ActivitiesController < ApplicationController

	def index
		@activities = Activity.all
	end

	def new
		@activity = Activity.new
	end

	def create
		@goal = Goal.find(params[:goal_id])
		@activity = Activity.new(activity_params)
		@activity.goal = @goal
		if @activity.save
			@activity.occurences = @activity.number_occurences
			@activity.upcoming_deadline = @activity.upcoming_due_dates[0]
			for i in 1..@activity.upcoming_due_dates.size-1
				Activity.new(activity_params) do |a|
					a.goal = @goal
					a.save #object must be persisted in order to find upcoming_due_dates
					a.occurences = @activity.occurences
					a.upcoming_deadline = @activity.upcoming_due_dates[i]
					a.save
				end
			end

			respond_to do |format|
		    if @activity.save
		      format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
		      format.js { }
		    else
		      format.html { render action: "new" }
		      format.js
		    end
		  end
		end
	end

	def edit
		set_activity
	end

	def update
		@goal = Goal.find(params[:goal_id])
		@activity = @goal.activities.find(params[:id])
		if activity_params[:status]
			@activity.add_point_and_decrement_occurences
			@activity.update(activity_params)
		else
			old_frequency = @activity.frequency
			currently_complete = @activity.frequency - @activity.remaining_for_period
			Activity.where(goal_id: @goal.id, description: @activity.description).each do |activity|
				activity.update(activity_params)
			end
			@activity.update(activity_params)
			@activity.occurences = @activity.number_occurences
			@activity.upcoming_deadline = @activity.upcoming_due_dates[0]
			@activity.remaining_for_period = @activity.frequency - @activity.activity_points
			for i in 1..@activity.upcoming_due_dates.size-1
				Activity.where(goal_id: @goal.id, description: @activity.description) do |a|
					a.occurences = @activity.occurences
					a.upcoming_deadline = @activity.upcoming_due_dates[i]
					a.save
				end
			end
		end

		@activity.save
		render nothing: true, status: :ok
	end

	def destroy
		set_activity.destroy
		render nothing: :true, status: :ok
	end

	private
		def set_activity
			@activity = Activity.find(params[:id])
		end

		def activity_params
			params.require(:activity).permit(:description, :period, :deadline, :status, :barrier, :facilitator, :goal_id, :trackable, :action, :frequency)
		end

end
