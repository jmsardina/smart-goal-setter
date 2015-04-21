class CommentsController < ApplicationController

  def create
    case comment_params[:commentable_type]
    when "Board"
      @commentable = Board.find(comment_params[:commentable_id])
    when "Comment"
      @commentable = Comment.find(comment_params[:commentable_id])
    end

    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
          format.js { }
        else
          format.html { render action: "new" }
          format.js
        end
      end
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
