class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save

    commentable_id = comment_params[:commentable_id].to_i
    case comment_params[:commentable_type]
    when "Board"
      Board.find(commentable_id).increment!(:comment_counter)
      redirect_to group_path(Board.find(commentable_id).group)
    when "Comment"
      Comment.find(commentable_id).increment!(:reply_counter)
      redirect_to group_path(Comment.find(commentable_id).commentable.group)
    # when "Goal"
    #   redirect_to goal_path(Goal.find(commentable_id))
    # when "Activity"
    #   redirect_to goal_path(Activity.find(commentable_id).goal)
    # when "Feed"
    #   redirect_to feeds_path
    end
  end

  private
    # def find_commentable
    #   resource, id = request.path.split('/')[1, 2]
    #   @commentable = resource.singularize.classify.constantize.find(id)
    # end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :commentable_type, :commentable_id)
    end
end
