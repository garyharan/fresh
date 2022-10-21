class GeoController < ApplicationController
  before_action :authenticate_user!

  def show
    @geo = GeoLocator.new(geo_params[:lat], geo_params[:lon]).find

    render json: @geo, status: :ok
  end

  private

  def geo_params
    params.require(:lat)
    params.require(:lon)
    params
  end
end
