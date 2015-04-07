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
		@activity.save ? redirect_to goal_path(@goal) : render :new
	end

	def edit
		set_activity
	end

	def update
		set_activity.update(params[:description])
	end


	def show
		set_activity
	end

	def destroy
		set_activity.destroy
	end

	private
		def set_activity
			@activity = Activity.find(params[:id])
		end

		def activity_params
			params.require(:activity).permit(:description, :period, :status, :barrier, :facilitator, :goal_id)
		end
end
