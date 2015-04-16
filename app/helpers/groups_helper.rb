module GroupsHelper
  def li_for_group(group)
    content_tag :li, :"data-group-id" => group.id do
      yield 
    end
  end
end
