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
			track_feed(@activity)
			@activity.occurences = @activity.number_occurences
			@activity.save
		end
		redirect_to goal_path(@goal)
	end

	def edit
		set_activity
	end

	def update
		@goal = Goal.find(params[:goal_id])
		@activity = @goal.activities.find(params[:id])
		@activity.update(activity_params)
		@activity.save
		track_feed(@activity)
		@activity.add_point_and_decrement_occurences
		render nothing: true, status: :ok
	end



	def show
		set_activity
	end

	def destroy
		# track_feed(@activity)
		set_activity.destroy
		render nothing: :true, status: :ok
	end

	private
		def set_activity
			@activity = Activity.find(params[:id])
		end

		def activity_params
			params.require(:activity).permit(:description, :period, :status, :barrier, :facilitator, :goal_id, :trackable, :action, :frequency)
		end

end
