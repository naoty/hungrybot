require "rails_helper"

RSpec.describe User, :type => :model do
  context "when an user is validated" do
    it "is invalid when its password is not correspond to password_confirmation" do
      user = build(:user, password: "password", password_confirmation: "wrong_password")
      expect(user).to be_invalid
    end

    it "is invalid when its name includes japanese characters" do
      user = build(:user, name: "太郎")
      expect(user).to be_invalid
    end

    it "is invalid when the capitalized same name has taken" do
      create(:user, name: "Naoty")
      user = build(:user, name: "naoty")
      expect(user).to be_invalid
    end
  end
end
