class Api::V1::Registered::LocationsController < RegisteredController
  before_action :set_service

  def fetch_locations
    response = @service.fetch_locations(query_params)
    render json: response
  end

  def fetch_nearby_locations
    response = @service.fetch_nearby_locations(nearby_location_params)
    render json: response
  end

  private

  def set_service
    @service ||= ::LocationService
  end

  def query_params
    params.permit(:q, :country_code, :page, :location_type, :sort_type, :sort_by, :page_limit)
  end

  def nearby_location_params
    params.permit(:latitude, :longitude, :distance, :location_type)
  end
end