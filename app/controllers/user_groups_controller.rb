class UserGroupsController < ApplicationController

	def create
		@user_group = UserGroup.new(user_group_params)
		if @user_group.save
			@invitation = Invitation.find(user_group_params[:invitation_id])
			@invitation.status = "accepted"
			@invitation.save
			# redirect_to group_path(params[:user_group][:group_id])
		else
			@invitation.destroy 
			# flash[:notice] = "Something went wrong... Try again."
			# render 'users/search_results'
		end
		redirect_to root_path
	end	

	def destroy
		@user_group = UserGroup.find(params[:user_group])
		@user_group.destroy
	end

	private
		def user_group_params
			params.require(:user_group).permit(:member_id, :group_id, :invitation_id)
		end
end
