class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_access_token, except: [:create]

  def show
    user = User.find_by!(name: params[:id])
    if user.authorized?(@access_token)
      render json: user
    else
      render json: {}, status: :unauthorized
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
