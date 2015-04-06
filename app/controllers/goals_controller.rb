class GoalsController < ApplicationController

	def index
		@goals = current_user.goals
	end

	def new
		@goal = Goal.new
	end

	def create
		@goal = Goal.create(goal_params)
	end

	def update
		set_goal.update(params[:description])
	end

	def edit
		set_goal
	end

	def show
		set_goal
	end

	def destroy
		set_goal.destroy
	end

	private
		def set_goal
			@goal = Goal.find(:id)
		end

		def goal_params
			params.require(:goal).permit(:user_id, :description)
		end

end
