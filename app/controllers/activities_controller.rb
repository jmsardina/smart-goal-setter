class ActivitiesController < ApplicationController

	def index
		@activities = Activity.all
	end

	def new
		@goal = Goal.find(params[:id])
		@activity = Activity.new
	end

	def create
		@activity = Activity.create(:description => params[:description])
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
			@activity = Activity.find(:id)
		end

end
