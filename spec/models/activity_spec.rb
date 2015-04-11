require 'rails_helper'

RSpec.describe Activity, type: :model do

  before do
    t = Time.local(2015, 4, 9)
    Timecop.freeze(t)
    # Timecop.travel(t)
  end

  context "model validations" do
    it 'has a valid factory' do
      expect(build(:activity)).to be_valid
    end

    it 'is invalid without a description' do
      activity = build(:activity, description: nil)
      expect(activity).to_not be_valid
    end

    it 'is invalid without frequency' do
      activity = build(:activity, frequency: nil)
      expect(activity).to_not be_valid
    end

    it 'is invalid without period' do
      activity = build(:activity, period: nil)
      expect(activity).to_not be_valid
    end
  end

  context 'model attributes' do
    let(:activity){create(:activity)}

    it 'has a #description attribute' do
      expect(activity.description).to eq("I will drink more water.")
    end

    it 'has a #frequency and #period attribute' do
      expect(activity.frequency).to eq(6)
      expect(activity.period).to eq("day")
    end
  end

  describe 'instance methods' do
    let(:activity){create(:activity)}

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
