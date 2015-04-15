class CheersController < ApplicationController

  def create
    @cheer = Cheer.new(cheer_params)
    @cheer.save
binding.pry
    cheerable_id = cheer_params[:cheerable_id].to_i
    case cheer_params[:cheerable_type]
    when "Board"
      Board.find(cheerable_id).increment!(:cheer_counter)
      redirect_to group_path(Board.find(cheerable_id).group)
    when "Comment"
      Comment.find(cheerable_id).increment!(:cheer_counter)
      redirect_to group_path(Board.find(Comment.find(cheerable_id).commentable_id).group)
    end
  end

  private

    def cheer_params
      params.require(:cheer).permit(:user_id, :cheerable_type, :cheerable_id)
    end
end
