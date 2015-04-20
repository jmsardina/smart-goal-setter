module CommentsHelper
  def div_for_comment(comment)
    content_tag :div, :"data-comment-id" => comment.id do
      yield 
    end
  end
end
