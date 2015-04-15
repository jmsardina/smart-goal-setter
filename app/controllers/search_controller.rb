class SearchController < ApplicationController
  def index
    @results = User.where(name: @result.name.include?(params[:keyword]))

    if @result
      # redirect_to
    # elsif !Search.for(params[:keyword]).empty?
      @results = Search.for(params[:keyword])
    else
      flash[:notice] = "No results match your search..."
      # redirect_to root_path
    end
  end

  # def show
  # end

  # def search
  # end

  def create
    @results = Search.for(params["keyword"])
    # if @results.empty?
    #   flash[:notice] = "No results match your search..."
    #   # redirect_to root_path
    # else
      @user_group = UserGroup.new
      render :results
    # end
  end

end