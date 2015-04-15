class CheersController < ApplicationController

  def create
    @cheer = Cheer.new(cheer_params)

    if !Cheer.find_by(user_id: current_user.id, cheerable_type: cheer_params[:cheerable_type], cheerable_id: cheer_params[:cheerable_id])
      @cheer.save
  
      cheerable_id = cheer_params[:cheerable_id].to_i

      case cheer_params[:cheerable_type]
      when "Board"
        Board.find(cheerable_id).increment!(:cheer_count)
        redirect_to group_path(Board.find(cheerable_id).group)
      when "Comment"
        Comment.find(cheerable_id).increment!(:cheer_count)
        redirect_to group_path(Board.find(Comment.find(cheerable_id).commentable_id).group)
      when "Group"
        Group.find(cheerable_id).increment!(:cheer_count)
        redirect_to group_path(Group.find(cheerable_id))
      end
    else
      redirect_to root_path
    end
  end

  private

    def cheer_params
      params.require(:cheer).permit(:user_id, :cheerable_type, :cheerable_id)
    end
end
