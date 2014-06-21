class FavoritesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_access_token, :authenticate_user

  def create
    favorite = @user.favorites.build(favorite_params)
    if favorite.save
      render json: favorite
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  private

  def authenticate_user
    @user = User.find_by!(name: params[:user_id])
    if !@user.authorized?(@access_token)
      render json: {}, status: :unauthorized
      return false
    end
  end

  def favorite_params
    params.require(:favorite).permit(:url)
  end
end
