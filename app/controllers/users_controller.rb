class UsersController < ApplicationController

	def search
		if params[:search]
   binding.pry
	    @results = User.search(params[:search]).order("created_at DESC")
	    render :search_results if @results.size > 0
     	render :text => "No results matching that query." if @results.empty?
	  end
	end

end
