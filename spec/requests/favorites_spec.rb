require "rails_helper"

SAMPLE_URL = "http://www.example.com"

RSpec.describe "Favorites", :type => :request do
  before do
    @user = create(:user, name: "naoty")
  end

  let :header do
    { AUTHORIZATION: "Bearer #{@user.access_token}" }
  end

  describe "POST /users/:user_id/favorites" do
    it "creates a favorite" do
      params = { favorite: { url: SAMPLE_URL } }
      expect {
        post user_favorites_path(user_id: @user.name), params, header
      }.to change(Favorite, :count).by(1)
    end
  end
end
