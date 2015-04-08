module ActivitiesHelper

  def li_for_activity(activity)
    content_tag :li, :"data-activity-id" => activity.id, class: (activity.complete? ? "completed" : "") do
      yield 
    end
  end
end
