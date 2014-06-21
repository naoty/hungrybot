require "rails_helper"

RSpec.describe "Users", :type => :request do
  describe "GET /users/:id" do
    before do
      @user = create(:user, name: "naoty")
    end

    let :header do
      { AUTHORIZATION: "Bearer #{@user.access_token}" }
    end

    it "responses 200" do
      get user_path(id: "naoty"), nil, header
      expect(response.status).to be 200
    end
  end

  describe "POST /signup" do
    it "creates new user" do
      params = {}
      params[:user] = { name: "naoty", password: "password", password_confirmation: "password"}
      expect { post signup_path, params }.to change(User, :count).by(1)
    end
  end
end
