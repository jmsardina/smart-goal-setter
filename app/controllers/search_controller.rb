class SearchController < ApplicationController
  def index
    @results = User.where(name: @result.name.include?(params[:keyword]))

    if @result
      # redirect_to
    # elsif !Search.for(params[:keyword]).empty?
      @results = Search.for(params[:keyword])
    else
      flash[:notice] = "I don't think I have that information..."
      redirect_to root_path
    end
  end

  # def show
  # end

  # def search
  # end

  def create
    # binding.pry
    @results = Search.for(params["keyword"])
    if @results.empty?
      flash[:notice] = "I don't think I know anything about that..."
      redirect_to root_path
    else
      render :results
    end
  end

end