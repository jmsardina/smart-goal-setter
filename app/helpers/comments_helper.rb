module CommentsHelper
  def li_for_comment(comment)
    content_tag :li, :"data-comment-id" => comment.id do
      yield 
    end
  end
end
