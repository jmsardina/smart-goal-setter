require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "model validations" do
    it 'has a valid factory' do
      expect(build(:group)).to be_valid
    end

    it 'is invalid without a name' do
      group = build(:group, name: nil)
      expect(group).to_not be_valid
    end
  end
end
