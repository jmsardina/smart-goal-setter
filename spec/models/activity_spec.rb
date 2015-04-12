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
    # let(:goal) { create(:goal, :with_activity, due_date: due_date) }

    describe "#number_occurences" do
      let(:activity) { create(:activity, period: period, frequency: frequency) }

      context "when set on a daily basis" do
        let(:period) { 'day' }
        let(:frequency) { 3 }
        
        it "should return the total number of times an activity will occur" do
          days = (activity.goal.due_date - activity.created_at.to_date)
          expect(activity.number_occurences).to eq(activity.frequency * days)
        end
      end

      context "when set on a weekly basis" do
        let(:period) { 'week' }
        let(:frequency) { 5 }
        
        it "should return the total number of times an activity will occur" do
          weeks = ((activity.goal.due_date - activity.created_at.to_date)/7).to_i
          expect(activity.number_occurences).to eq((activity.frequency * weeks))
        end
      end

      context "when set on a monthly basis" do
        let(:period) { 'month' }
        let(:frequency) { 2 }
        
        it "should return the total number of times an activity will occur" do
          months = ((activity.goal.due_date - activity.created_at.to_date)/30).to_i
          expect(activity.number_occurences).to eq((activity.frequency * months))
        end
      end

      context "when set on a yearly basis" do
        let(:period) { 'year' }
        let(:frequency) { 2 }
        
        it "should return the total number of times an activity will occur" do
          years = ((activity.goal.due_date - activity.created_at.to_date)/365).to_i
          expect(activity.number_occurences).to eq((activity.frequency * years))
        end
      end
    end

    describe '#upcoming_due_dates' do
      # let(:goal) { create(:goal, :with_activity, due_date: due_date) }
      let(:activity) { create(:activity, period: period)}

      context "when set on a daily basis" do
        # let(:due_date) { 12.days.from_now }
        let(:period) { 'day' }

        it "should return an array of all the daily due dates" do
          days_to_due_date = (activity.goal.due_date - activity.created_at.to_date)
          expected_due_dates = (1..days_to_due_date).map { |i| i.days.from_now.to_date }

          expect(activity.upcoming_due_dates).to eq(expected_due_dates)
        end
      end

      context "when set on a daily basis" do
        let(:period) { 'week' }

        it "should return an array of all the weekly due dates" do
          weeks_to_due_date = ((activity.goal.due_date - activity.created_at.to_date)/7).to_i
          expected_due_dates = (1..weeks_to_due_date).map { |i| i.weeks.from_now.to_date }
          expected_due_dates << activity.goal.due_date unless expected_due_dates.include?(activity.goal.due_date)

          expect(activity.upcoming_due_dates).to eq(expected_due_dates)
        end
      end

      context "when set on a monthly basis" do
        let(:period) { 'month' }

        it "should return an array of all the monthly due dates" do
          months_to_due_date = ((activity.goal.due_date - activity.created_at.to_date)/30)
          expected_due_dates = (1..months_to_due_date).map { |i| i.months.from_now.to_date }
          expected_due_dates << activity.goal.due_date unless expected_due_dates.include?(activity.goal.due_date)

          expect(activity.upcoming_due_dates).to eq(expected_due_dates)
        end
      end

      context "when set on a yearly basis" do
        let(:period) { 'year' }
        let(:frequency){ 4 }

        it "should return an array of all the yearly due dates" do
          years_to_due_date = ((activity.goal.due_date - activity.created_at.to_date)/365)
          expected_due_dates = (1..years_to_due_date).map { |i| i.years.from_now.to_date }
          expected_due_dates << activity.goal.due_date unless expected_due_dates.include?(activity.goal.due_date)
          
          expect(activity.upcoming_due_dates).to eq(expected_due_dates)
        end
      end

    end
    
    describe "#restart_activity_counter" do
      let(:activity) { create(:activity)}
      t = Time.local(2015, 4, 12)
      Timecop.travel(t)

      it "should restart activity counter at the end of the cycle" do
        activity.restart_activity_counter
        expect(activity.remaining_for_period).to eq(6)
      end
    end
  end
end
