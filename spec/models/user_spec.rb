require 'rails_helper'

RSpec.describe User, type: :model do

  describe "model validations" do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'is invalid without a name' do
      user = build(:user, name: nil)
      expect(user).to_not be_valid
    end
  end
end
