class FeedsController < ApplicationController

	def index
		@feeds = Feed.order("created_at DESC").limit(20)
	end

end
