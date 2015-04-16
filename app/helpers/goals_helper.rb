module GoalsHelper
  def li_for_goal(goal)
    content_tag :li, :"data-goal-id" => goal.id, class: (goal.complete? ? "completed" : "") do
      yield
    end
  end

  def total_activity_occurence
    occurence = 0
    self.activities.each do |activity|
      occurence += activity.number_occurences
    end
    occurence
  end

  def total_remaining_occurence
    remaining = 0
    self.activities.each do |activity|
      remaining += activity.occurences
    end
    remaining
  end
end
