class GroupsController < ApplicationController

	def index
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		@group.creator_id = current_user.id
		@group.boards << Board.create(name: "Main")
		if @group.save
			UserGroup.create(group_id: @group.id, member_id: current_user.id)
			redirect_to group_path(@group)
		else
			flash[:notice] = "Something went wrong...Try again."
			render :new
		end
	end

	def edit
		set_group
	end

	def update
		set_group.update(group_params)
		if @group.save
			redirect_to group_path(@group)
		else
			flash[:notice] = "Something went wrong... Try again."
			render :new
		end
	end


	def show
		set_group
		@comment = Comment.new
		@board = Board.where(group_id: set_group.id).first
		@comments = Comment.where(commentable_type: "Board", commentable_id: @board.id).order(:created_at).reverse_order
		# @board = Board.new
		@cheer = Cheer.new
		@members = @group.members
		@tags = @group.tags
		@invitation = Invitation.new
		@board = Board.where(group_id: set_group.id).first
	end

	def destroy
		set_group.destroy
	end

	private
		def set_group
			@group = Group.find(params[:id])
		end

		def group_params
			params.require(:group).permit(:name, :description, :creator_id, :avatar, tag_ids: [])
		end
end
