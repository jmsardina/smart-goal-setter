module UsersHelper
  def li_for_user(user)
    content_tag :li, :"data-user-id" => user.id do
      yield 
    end
  end
end
