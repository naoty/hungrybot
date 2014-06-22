class FavoritesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_access_token, :authenticate_user

  RECOMMENDATION_DISTANCE = 0.5

  def index
    @favorites = @user.favorites.page(params[:page])
  end

  def create
    favorite = @user.favorites.build(favorite_params)
    if favorite.save
      render json: favorite, status: :created
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    favorite = @user.favorites.find(params[:id])
    if favorite.destroy
      render json: favorite, status: :ok
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  def recommend
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f

    if latitude == 0.0 && longitude == 0.0
      render json: {}, status: :bad_request
    end

    favorites = @user.favorites.near([latitude, longitude], RECOMMENDATION_DISTANCE)
    favorite = favorites.sample

    if favorite.blank?
      render json: {}, status: :not_found
      return
    end

    begin
      favorite.pushover(@user.pushover_token)
      render json: favorite, status: :accepted
    rescue
      render json: {}, status: :forbidden
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit(:url)
  end
end
