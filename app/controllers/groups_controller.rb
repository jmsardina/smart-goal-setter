class GroupsController < ApplicationController

	def index
		if current_user
			@groups = current_user.groups
		else
			@groups = Group.all
			render 'welcome_page'
		end
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		@group.creator_id = current_user.id
		if @group.save
		@user_group = UserGroup.create(group_id: @group.id, user_id: current_user.id)
			redirect_to goals_path
		else
			flash[:notice] = "Something went wrong...Try again."
			render :new
		end
	end

	def update
		@group = Group.find(params[:group_id])
      @user_to_add = User.find(params[:user_id])
      @group.members << @user_to_add
      redirect_to group_path
	end

	def edit
		set_group
	end

	def show
		set_group
	end

	def destroy
		set_group.destroy
	end

	private
		def set_group
			@group = Group.find(params[:id])
		end

		def group_params
			params.require(:group).permit(:name, :description, :creator_id)
		end

end
