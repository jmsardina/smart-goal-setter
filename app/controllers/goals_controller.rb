class GoalsController < ApplicationController
	before_action :authenticate_user!

	def index
		if current_user
			@goals = current_user.goals.order("due_date ASC")
			@activities = []
			current_user.activities.order(:upcoming_deadline).each do |activity|
				@activities << activity if activity.valid_cycle_dates === Time.now.to_date
			end
		else
			@goals = Goal.all
			render 'welcome_page'
		end
	end

	def new
		@goal = Goal.new
	end

	def create
		@goal = Goal.new(goal_params)
		@goal.user = current_user
		if @goal.save
			redirect_to goal_path(@goal)
		else
			flash[:notice] = "Something went wrong...Try again."
			render :new
		end
	end

	def update
		set_goal.update(goal_params)
		if @goal.save
			redirect_to goal_path(@goal)
		else
			flash[:notice] = "Something went wrong...Try again."
			render :new
		end
	end

	def edit
		set_goal
	end

	def show
		set_goal
		@activity = Activity.new
		@activities = @goal.activities.order("upcoming_deadline")
		@activities.each{|activity| activity.restart_activity_counter}
		@tags = @goal.tags
	end

	def destroy
		set_goal.destroy
		render nothing: :true, status: :ok
	end

	private
		def set_goal
			@goal = Goal.find(params[:id])
		end

		def goal_params
			params.require(:goal).permit(:name, :user_id, :description, :measure, :consequence, :status, :due_date, :motivation, :potential_barrier, :coping_strategy, :support, tag_ids: [])
		end
end
