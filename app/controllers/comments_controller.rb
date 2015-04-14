class CommentsController < ApplicationController

  def create
    # binding.pry
    # @board = Board.find(params[:id])
    @user = current_user
    @group = Group.find(params[:id])
    @comment = Comment.new(content: params[:comment][:content], user_id: current_user.id, commentable_type: "Group", commentable_id: @group.id)
    if @comment.save
      redirect_to group_path(@group)
    else
      render nothing: true, status: :ok
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_type, :commentable_id)
  end
end
