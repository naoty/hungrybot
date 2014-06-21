require "rails_helper"

RSpec.describe "Users", :type => :request do
  describe "POST /signup" do
    it "creates new user" do
      params = {}
      params[:user] = { name: "naoty", password: "password", password_confirmation: "password"}
      expect { post signup_path, params }.to change(User, :count).by(1)
    end
  end
end
