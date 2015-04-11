class UserGroupsController < ApplicationController

	def create
		@user_group = UserGroup.new(user_group_params)
		binding.pry
	end	
	# 	if params[:search]
 #   # binding.pry
	#     @results = User.search(params[:search]).order("created_at DESC")
	#     render :search_results if @results.size > 0
 #     	render :text => "No results matching that query." if @results.empty?
	#   end
	# end

	private
		def user_group_params
			params.require(:user_group).permit(:user_id, :group_id)
		end

end
