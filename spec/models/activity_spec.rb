require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe "#restart_activity_counter" do

    before do
      t = Time.local(2015, 4, 9)
      Timecop.freeze(t)
      # Timecop.travel(t)
    end

    let!(:user){User.create({name:"Jane", email: "jane2@example.com", password: "password123"})}

    let!(:goal){Goal.create({name:"Lose weight", description: "I want to lose 10lbs.", user_id: 1, due_date: Date.new(2015, 4, 23)})}

    let!(:activity){Activity.create({description: "Drink more water.", frequency: 6, period: "day", goal_id: 1
      })}

    context "#number_occurences" do
      it "should return the total number of times an activity will occur" do
        expect(activity.number_occurences).to eq(84)
      end
    end
    
    context "#restart_activity_counter" do
      t = Time.local(2015, 4, 12)
      Timecop.travel(t)

      
      it "should restart activity counter at the end of the cycle" do
        activity.restart_activity_counter
        expect(activity.remaining_for_period).to eq(6)
      end
    end
  end
end
