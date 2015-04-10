FactoryGirl.define do
  factory :activity do
    goal
    description {"I will drink more water."}
    frequency {6}
    period {"day"}
    barrier {"The barrier for this activity"}
    facilitator {"Facilitator for this activity"}
  end

end
