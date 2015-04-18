module FeedsHelper

def li_for_feed(feed)
    content_tag :li, :"data-feed-id" => feed.id, class: (feed.complete? ? "completed" : "") do
      yield 
    end
end

end
