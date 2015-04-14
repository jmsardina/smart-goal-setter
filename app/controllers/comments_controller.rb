class CommentsController < ApplicationController

  def create
    # binding.pry
    # @board = Board.find(params[:id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to root_path
    else
      render nothing: true, status: :ok
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
