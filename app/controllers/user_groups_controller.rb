class UserGroupsController < ApplicationController

	def create
		@user_group = UserGroup.new(user_group_params)
		if @user_group.save
			binding.pry
			redirect_to group_path(params[:user_group][:group_id])
		else
			flash[:notice] = "Something went wrong... Try again."
			render 'users/search_results'
		end
	end
	# 	if params[:search]
 #   # binding.pry
	#     @results = User.search(params[:search]).order("created_at DESC")
	#     render :search_results if @results.size > 0
 #     	render :text => "No results matching that query." if @results.empty?
	#   end
	# end

	def destroy
		@user_group = UserGroup.find(params[:user_group])
		@user_group.destroy
	end

	private
		def user_group_params
			params.require(:user_group).permit(:member_id, :group_id)
		end
end
