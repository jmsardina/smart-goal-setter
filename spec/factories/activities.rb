FactoryGirl.define do
  factory :activity do
    # goal
    association :goal, factory: :goal
    description {"I will drink more water."}
    # goal_id {1}
    frequency {4}
    period {"week"}
    barrier {"The barrier for this activity"}
    facilitator ("Facilitator for this activity")
  end

end
