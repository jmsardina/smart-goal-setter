class GoalsController < ApplicationController

	def index
		if current_user
			@goals = current_user.goals
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
		set_goal.update(params[:description])
	end

	def edit
		set_goal
	end

	def show
		set_goal
		@activity = Activity.new
	end

	def destroy
		set_goal.destroy
	end

	private
		def set_goal
			@goal = Goal.find(params[:id])
		end

		def goal_params
			params.require(:goal).permit(:user_id, :description)
		end

end
