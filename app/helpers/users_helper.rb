module UsersHelper
  def div_for_user(user)
    content_tag :div, :"data-user-id" => user.id do
      yield 
    end
  end
end
